Select 
  * 
from 
  Scores;
---What is the total number od students for each gender?
select 
  gender, 
  count(gender) as Numbers 
from 
  Scores 
group by 
  gender;
----How many students in  each  Ethnic Group?
select 
  isnull(
    nullif(EthnicGroup, ''), 
    'Not Specified'
  ) as [Ethnic Group], 
  count(EthnicGroup) as Numbers 
from 
  Scores 
group by 
  EthnicGroup 
order by 
  2 desc;
--How many female and male in each EthnicGroup?
select 
  isnull(
    nullif(EthnicGroup, ''), 
    'Not Specified'
  ) as [Ethnic Group], 
  male, 
  female 
from 
  (
    select 
      EthnicGroup, 
      gender 
    from 
      scores
  ) as a pivot(
    count(gender) for gender in (male, female)
  ) as b;
---- Display parent education for the students
select 
  isnull(
    nullif(ParentEduc, ''), 
    'Not Specified'
  ) as [Parent Education], 
  count(ParentEduc) as Number 
from 
  Scores 
group by 
  ParentEduc 
order by 
  2 desc;
----Count Lunch Type for the students
select 
  LunchType as [Lunch Type], 
  count(LunchType) as Number 
from 
  Scores 
group by 
  LunchType 
order by 
  2 desc;
----How many students Took Test Prep
select 
  isnull(
    nullif(TestPrep, ''), 
    'Not Specified'
  ) as [Test Prep], 
  count(TestPrep) as Number 
from 
  Scores 
group by 
  TestPrep 
order by 
  2 desc;
---What is the Parent Marital Status for the students
select 
  isnull(
    nullif(ParentMaritalStatus, ''), 
    'Not Specified'
  ) as [Parent Marital Status], 
  count(ParentMaritalStatus) as Number 
from 
  Scores 
group by 
  ParentMaritalStatus 
order by 
  2 desc;
---Count how many  students practie sport
select 
  isnull(
    nullif(Practicesport, ''), 
    'Not Specified'
  ) as [Practice Sport], 
  count(Practicesport) as Number 
from 
  Scores 
group by 
  Practicesport 
order by 
  2 desc;
---- Count how many students were the first child
select 
  isnull(
    nullif(Isfirstchild, ''), 
    'Not Specified'
  ) as [the first child], 
  count(Isfirstchild) as Number 
from 
  Scores 
group by 
  Isfirstchild 
order by 
  2 desc;
-----count  number of siblings for students
select 
  isnull(
    nullif(NrSiblings, ''), 
    'Not Specified'
  ) as [ number of siblings ], 
  count(NrSiblings) as Number 
from 
  scores 
group by 
  NrSiblings 
order by 2 desc; 
 ----Display transportion type for the students
select 
  isnull(
    nullif(TransportMeans, ''), 
    'Not Specified'
  ) as [ Transportion Type ], 
  count(TransportMeans) as Number 
from 
  scores 
group by 
  TransportMeans 
order by 
  2
  desc;
  -----What is the total time the students spent studying
select 
  isnull(
    nullif(WklyStudyHours, ''), 
    'Not Specified'
  ) as [Weekly Study Hours ], 
  count(WklyStudyHours) as Number 
from 
  scores 
group by 
  WklyStudyHours 
order by 
  2 desc;
  --Display average Grades for  subjects for each  Ethnic Group
  with GradesByEthnicGroup as(
    select 
      isnull(
        nullif(EthnicGroup, ''), 
        'Not Specified'
      ) as [Ethnic Group], 
      avg(MathScore) MathScore, 
      avg(ReadingScore) ReadingScore, 
      avg(WritingScore) WritingScore, 
      avg(
        (
          MathScore + ReadingScore + WritingScore
        )/ 3
      ) as[Total Average] 
    from 
      Scores 
    group by 
      EthnicGroup
  ) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  GradesByEthnicGroup;
--Display average Grades for  subjects by parent education
with GradesByEducation as(
  select 
    isnull(
      nullif(ParentEduc, ''), 
      'Not Specified'
    ) as [Parent Education], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    ParentEduc
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  GradesByEducation;
--Display average Grades for  subjects by lunch Type
with GradesByLunchType as (
  select 
    LunchType as [Lunch Type], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    LunchType
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  GradesByLunchType;
--Display average Grades for  subjects by Test Prep
with GradesByTestPrep as (
  select 
    isnull(
      nullif(TestPrep, ''), 
      'Not Specified'
    ) as [Test Prep], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    TestPrep
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  GradesByTestPrep;
---Display average Grades for  subjects by Parent Marital Status
with GradesByMaritalStatus as (
  select 
    isnull(
      nullif(ParentMaritalStatus, ''), 
      'Not Specified'
    ) as [Marital Status], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    ParentMaritalStatus
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  GradesByMaritalStatus;
---Display average Grades for  subjects by Practice sport
with Practicesport as (
  select 
    isnull(
      nullif(Practicesport, ''), 
      'Not Specified'
    ) as [Practice sport], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    Practicesport
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  Practicesport;
---Display average Grades for  subjects by first child
with FirstChild as (
  select 
    isnull(
      nullif(Isfirstchild, ''), 
      'Not Specified'
    ) as [Isfirst child], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    Isfirstchild
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  FirstChild;
---Display average Grades for  subjects by No. of siblings
with NrSiblings as (
  select 
    isnull(
      nullif(NrSiblings, ''), 
      'Not Specified'
    ) as [Nr Siblings], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    NrSiblings
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  NrSiblings;
---Display average Grades for  subjects by Type of Transportion
with TransportType as (
  select 
    isnull(
      nullif(TransportMeans, ''), 
      'Not Specified'
    ) as [Transport Type], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    TransportMeans
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  TransportType;
--Display average Grades for  subjects by study hours
with WklyStudyHours as (
  select 
    isnull(
      nullif(WklyStudyHours, ''), 
      'Not Specified'
    ) as [WklyStudyHours], 
    avg(MathScore) MathScore, 
    avg(ReadingScore) ReadingScore, 
    avg(WritingScore) WritingScore, 
    avg(
      (
        MathScore + ReadingScore + WritingScore
      )/ 3
    ) as[Total Average] 
  from 
    Scores 
  group by 
    WklyStudyHours
) 
select 
  *, 
  DENSE_RANK() over (
    order by 
      [Total Average] desc
  ) as Rank 
from 
  WklyStudyHours;
