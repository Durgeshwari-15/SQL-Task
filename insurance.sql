ELECT * FROM public.agent
ORDER BY agent_id ASC


SELECT * FROM public.agent
ORDER BY agent_id ASC 


create or replace function claim_status_update()
return trigger as $$
begin
if New.amount_claimed >10000 then
New.status = 'Approved';
elseif New.amount_claimed >200000 then 
New.status = 'Rejected';
else
New.status = 'pending';
end if;
return new;
end;
$$ language plpgsql;



create trigger claimsstatus
before insert on claims
for each row
execute function claim_status_update()


insert into claims (claim_id, claim_date, amount_claimed, policy_id, approved_by) values (2001, '2025-04-15', 9000, 451, 'Nukul Mehta')

select * from claims where claim_id =2001

select a.agent_id, first_Name || ' ' || last_Name as agent_Name, count (p.policy_id) as policy_sold
from agent a left join policies p on a.agent_id = p.agent_id
group by a.agent_id, agent_name order by policy_sold desc


create procedure policy_sold_by_agent(inout agentid int default null, inout agentname varchar default null, inout policysold int default null)
language plpgsql as $$
begin
select a.agent_id, first_Name || ' ' || last_Name as agent_Name, count (p.policy_id) as policy_sold into agentid, agentname, policysold
from agent a left join policies p on a.agent_id = p.agent_id
group by a.agent_id, agent_name order by policy_sold desc;
end;
$$;

call policy_sold_by_agent()

select status, count(*) as policy_count
from claims group by status

select c. customer_id, first_name ||' '|| last_name as customer_name, p.policy_type, payment_id, amount, payment_method
from customers c join policies p on c.customer_id = p.customer_id
join payments pa on p.policy_id = pa.policy_id


alter table policies add column isexpired boolean default 'false';


CREATE OR REPLACE FUNCTION expire_policy()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.end_date < CURRENT_DATE THEN
        NEW.isexpired := true;
    ELSE
        NEW.isexpired := false;
    END IF;

    RETURN NEW;
END;
$$;

DUPLICATE CLAIM :-
 create trigger expiringpolicy
 before insert or update on policies
 for each row
 execute function expire_policy()

 insert into policies values (1003, 'car ins', 450000, 45000, '2025-04-16', '2026-03-15', 30, 24, 'Ajay varma')

 select * from policies where policy_id = 1003


CREATE OR REPLACE FUNCTION prevent_duplicate()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM claims 
        WHERE policy_id = NEW.policy_id
          AND claim_date = NEW.claim_date
    ) THEN
        RAISE EXCEPTION 'Duplicate claim not allowed';
    END IF;

    RETURN NEW;
END;
$$;


 create trigger check_duplicate
before insert on claims
 for each row
 execute function prevent_duplicate()



AUTO CLACULATING AGENT :-
CREATE OR REPLACE FUNCTION auto_commission_cal()
RETURNS TRIGGER AS $$
DECLARE
    rate REAL;
BEGIN
    SELECT commission_rate INTO rate 
    FROM agent 
    WHERE agent_id = NEW.agent_id;

    INSERT INTO agent_commission (agent_id, policy_id, commission) 
    VALUES (NEW.agent_id, NEW.policy_id, NEW.premium_amount * rate);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

 CREATE TRIGGER commission_cal
AFTER INSERT ON policies
FOR EACH ROW
EXECUTE FUNCTION auto_commission_cal();


insert into policies values (1004, 'Health', 450000, 45000, '2022-04-20', '2026-03-15', 30, 21, 'Ajay varma');
STORED PROCEDURE:-
CREATE OR REPLACE PROCEDURE auto_renew_policies()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE policies p
    SET expiry_date = expiry_date + INTERVAL '1 year',
        status = 'Renewed'
    WHERE expiry_date <= CURRENT_DATE
      AND status = 'Active'
      AND NOT EXISTS (
          SELECT 1 FROM claims c
          WHERE c.policy_id = p.policy_id AND c.status != 'Resolved'
      )
      AND NOT EXISTS (
          SELECT 1 FROM payments pay
          WHERE pay.policy_id = p.policy_id AND pay.status != 'Paid'
      );
END;
$$;


CREATE OR REPLACE PROCEDURE auto_process_payments()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE payments
    SET status = 'Paid',
        payment_date = CURRENT_DATE
    WHERE due_date <= CURRENT_DATE
      AND status = 'Pending';
END;
$$;

CREATE OR REPLACE PROCEDURE daily_summary_report()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Date: %', CURRENT_DATE;
    
    RAISE NOTICE 'Policies processed today: %',
        (SELECT COUNT(*) FROM policies WHERE DATE(updated_at) = CURRENT_DATE);

    RAISE NOTICE 'Claims processed today: %',
        (SELECT COUNT(*) FROM claims WHERE DATE(updated_at) = CURRENT_DATE);

    RAISE NOTICE 'Payments processed today: %',
        (SELECT COUNT(*) FROM payments WHERE DATE(updated_at) = CURRENT_DATE);
END;
$$;


CREATE TABLE policies_audit (
    audit_id SERIAL PRIMARY KEY,
    operation_type TEXT,
    policy_id INT,
    changed_data JSONB,
    changed_by TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE OR REPLACE FUNCTION audit_policies()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' OR TG_OP = 'DELETE' THEN
        INSERT INTO policies_audit(operation_type, policy_id, changed_data, changed_by)
        VALUES (
            TG_OP,
            COALESCE(NEW.policy_id, OLD.policy_id),
            row_to_json(COALESCE(NEW, OLD)),
            CURRENT_USER
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_audit_policies
AFTER INSERT OR UPDATE OR DELETE ON policies
FOR EACH ROW
EXECUTE FUNCTION audit_policies();
