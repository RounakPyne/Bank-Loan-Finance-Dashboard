/*Created Database*/ 
create database Finance_Loan;

/*Enabling Database*/
use Finance_Loan;

/*Total Loan applications*/
select count(id) as `Total Loan applications` from `financial_loan`;

/*Month to date Loan Application*/
select count(id) as `MTD Loan Application` from `financial_loan` where month(issue_date) = 12 and year(issue_date) = 2021;

/*Previous Month Loan Application*/
select count(id) as `MTD Loan Application` from `financial_loan` where month(issue_date) = 11 and year(issue_date) = 2021;

/*Total funded amount*/
select sum(loan_amount) as `Total funded amount` from financial_loan; 

/*Month to date Total funded amount*/
select sum(loan_amount) as `Month to date total funded amount` from `financial_loan` where month(issue_date) = 12 and year(issue_date) = 2021;

/*Previous month total funded amount*/
select sum(loan_amount) as `Previous month Total funded amount` from `financial_loan` where month(issue_date) = 11 and year(issue_date) = 2021;

/*Total amount recieved*/
select sum(total_payment) as `Total amount recieved` from `financial_loan`;

/*Month to date Total amount recieved*/
select sum(total_payment) as `Month to date total amount recieved` from `financial_loan` where month(issue_date) = 12 and year(issue_date) = 2021;

/*Previous month total amount recieved*/
select sum(total_payment) as `Previous month Total amount recieved` from `financial_loan` where month(issue_date) = 11 and year(issue_date) = 2021;

/*Average Interest Rate*/
select concat(round(avg(int_rate),4)*100,'%') as `Average Interest Rate` from financial_loan;

/*Month to date Average Interest Rate*/
select concat(round(avg(int_rate),4)*100,'%') as `Month to date Average Interest Rate` from `financial_loan` where month(issue_date) = 12 and year(issue_date) = 2021;

/*Previous month Average Interest Rate*/
select concat(round(avg(int_rate),4)*100,'%') as `Previous month Average Interest Rate` from `financial_loan` where month(issue_date) = 11 and year(issue_date) = 2021;

/*Average dti*/
select concat(round(avg(dti),4)*100,'%') as `Average dti` from financial_loan;

/*Month to date dti*/
select concat(round(avg(dti),4)*100,'%') as `Month to date Average dti` from `financial_loan` where month(issue_date) = 12 and year(issue_date) = 2021;

/*Previous month dti*/
select concat(round(avg(dti),4)*100,'%') as `Previous month Average dti` from `financial_loan` where month(issue_date) = 11 and year(issue_date) = 2021;

/*Good loan percentage*/
SELECT
       concat((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id),'%') AS Good_Loan_Percentage FROM financial_loan;
    
  /*Good Loan Applications*/  
  select count(*) as `Good Loan Applications` from financial_loan where loan_status = 'Fully Paid' OR loan_status = 'Current';

/*Good Loan Funded Amount*/
 select sum(loan_amount) as `Good Loan Funded Amount` from financial_loan where loan_status = 'Fully Paid' OR loan_status = 'Current';
 
 /*Good Loan Amount Received*/
  select sum(total_payment) as `Good Loan Amount Received` from financial_loan where loan_status = 'Fully Paid' OR loan_status = 'Current';
 
 /*Bad Loan Percentage*/
SELECT
       concat((COUNT(CASE WHEN loan_status ='Charged off' THEN id END) * 100.0) / 
	COUNT(id),'%') AS Bad_Loan_Percentage FROM financial_loan; 
 
 /*Bad Loan Applications*/
  select count(*) as `Bad Loan Applications` from financial_loan where loan_status = 'Charged off';
  
  /*Bad Loan Funded Amount*/
  select sum(loan_amount) as `Bad Loan Funded Amount` from financial_loan where loan_status = 'Charged off';
   
  /*Bad Loan Amount Received*/
  select sum(total_payment) as `Bad Loan Amount Received` from financial_loan where loan_status = 'Charged off';
  
  
  /*Loan Status*/
  select
  loan_status, count(*) as `Application status`, sum(total_payment) as `Total Amount Recieved`, sum(loan_amount) as `Total Amount funded`,
  concat(round(avg(int_rate*100),2),'%') as `Interest rate`, concat(round(avg(dti*100),2),'%') as `DTI`
  from financial_loan
  group by loan_status;
 /*Loan Status by month*/
 SELECT loan_status, SUM(total_payment) AS 'Month to date Total amount recieved', SUM(loan_amount) AS 'Month to date Total amount funded'
FROM financial_loan WHERE MONTH(issue_date) = 12 GROUP BY loan_status;

  /*Bank Loan report by month*/
  
  select
  monthname(issue_date) as `Month Name`,
  count(*) as `Total loan Application`,
  sum(loan_amount) as `Total amount funded`,
  SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`
  from financial_loan
  group by `Month Name`,month(issue_date)
  order by month(issue_date);
  
  /*analysis by STATE*/
  select address_state,
  count(*) as `Total loan Application`,
  sum(loan_amount) as `Total amount funded`,
  SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`
  from financial_loan
  group by address_state
  order by address_state;
  
  /*analysis by Term*/
  select term,
  count(*) as `Total loan Application`,
  sum(loan_amount) as `Total amount funded`,
  SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`
  from financial_loan
  group by term
  order by term;
  
   /*analysis by Employee length*/
  select emp_length as `Employee length`,
  count(*) as `Total loan Application`,
  sum(loan_amount) as `Total amount funded`,
  SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`
  from financial_loan
  group by emp_length
  order by emp_length;
  
   /*analysis by purpose*/
  select purpose ,
  count(*) as `Total loan Application`,
  sum(loan_amount) as `Total amount funded`,
  SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`
  from financial_loan
  group by purpose
  order by purpose;
  


/*Which term gets the highest installments*/
 select term, count(*) as `Total loan Application`, sum(loan_amount) as `Total amount funded`, SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`, round(sum(installment),2) as `installment`
  from financial_loan
  group by term
  order by term;
  
  /*Amount disbursed and recieved based on verfication status*/
  
  select verification_status, count(*) as `Total loan Application`, sum(loan_amount) as `Total amount funded`, SUM(total_payment) AS `Total amount recieved`,
  round(sum(dti),2) as `DTI`
  from financial_loan
  group by verification_status
  order by verification_status;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  