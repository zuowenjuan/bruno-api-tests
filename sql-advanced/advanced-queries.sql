SQL进阶实战项目 - 学生成绩管理系统
日期：2026年3月20日

1. 查看所有学生
SELECT * FROM students;

2. 查看所有课程   SELECT * FROM courses;

3. 查看所有成绩   SELECT * FROM scores;

4. 每个学生的平均分
SELECT 
s.name AS Student,    
ROUND(AVG(sc.score), 2) AS avg_score
FROM students s
LEFT JOIN scores sc ON s.student_id = sc.student_id
GROUP BY s.student_id, s.name;

5. 每门课的平均分   
SELECT        
c.course_name AS Course,       
ROUND(AVG(sc.score), 2) AS avg_score,       
COUNT(*) AS exam_count   
FROM courses c   
LEFT JOIN scores sc ON c.course_id = sc.course_id   
GROUP BY c.course_id, c.course_name;    

6. 不及格学生   
SELECT        
s.name AS Student,       
c.course_name AS Course,       
sc.score AS Score   FROM scores sc   
JOIN students s ON sc.student_id = s.student_id   
JOIN courses c ON sc.course_id = c.course_id   
WHERE sc.score < 60;  

7. 成绩大于等于90的学生   
SELECT        
s.name AS Student,       
c.course_name AS Course,       
sc.score AS Score   
FROM scores sc   
JOIN students s ON sc.student_id = s.student_id   
JOIN courses c ON sc.course_id = c.course_id   
WHERE sc.score >= 90   
ORDER BY sc.score DESC;    

8. 三班的学生名单   SELECT * FROM students WHERE class = 'Class 3';      -- 

9. 张老师教的课程   SELECT * FROM courses WHERE teacher = 'Mr. Zhang';      -- 

10. 2024年1月以后的考试记录   
SELECT        
s.name AS Student,       
c.course_name AS Course,    
sc.score AS Score,       
sc.exam_date AS Exam_Date   
FROM scores sc   
JOIN students s ON sc.student_id = s.student_id   
JOIN courses c ON sc.course_id = c.course_id   
WHERE sc.exam_date >= '2024-01-01'   
ORDER BY sc.exam_date;      -- 

11. 成绩详情（学生、课程、成绩、日期）   
SELECT        
s.name AS Student,       
c.course_name AS Course,       
sc.score AS Score,       
sc.exam_date AS Exam_Date   
FROM scores sc   
JOIN students s ON sc.student_id = s.student_id   
JOIN courses c ON sc.course_id = c.course_id   
ORDER BY s.name, sc.exam_date;      -- 

12. 学生总成绩排名   
SELECT        
s.name AS Student,       
SUM(sc.score) AS total_score,       
RANK() OVER (ORDER BY SUM(sc.score) DESC) AS `rank`   
FROM students s   
JOIN scores sc ON s.student_id = sc.student_id   
GROUP BY s.student_id, s.name;      -- 

13. 每门课的最高分及对应的学生   
SELECT        
c.course_name AS Course,       
sc.score AS Highest_Score,       
s.name AS Student   
FROM scores sc   
JOIN courses c ON sc.course_id = c.course_id   
JOIN students s ON sc.student_id = s.student_id   
WHERE (sc.course_id, sc.score) IN (       
SELECT course_id, MAX(score)       
FROM scores       
GROUP BY course_id   )   
ORDER BY c.course_id;      -- 

14. 班级平均分   SELECT        
s.class AS Class,       
ROUND(AVG(sc.score), 2) AS avg_score,       
COUNT(DISTINCT s.student_id) AS student_count   
FROM students s   
LEFT JOIN scores sc ON s.student_id = sc.student_id   
GROUP BY s.class;      -- 

15. 选修3门课以上的学生   
SELECT        
s.name AS Student,       
COUNT(*) AS course_count   
FROM students s   
JOIN scores sc ON s.student_id = sc.student_id   
GROUP BY s.student_id, s.name   
HAVING COUNT(*) >= 3;      -- 

16. 窗口函数排名（按总分）   
SELECT        
s.name AS Student,       
SUM(sc.score) AS total_score,       
RANK() OVER (ORDER BY SUM(sc.score) DESC) AS `rank`   
FROM students s   
JOIN scores sc ON s.student_id = sc.student_id   
GROUP BY s.student_id, s.name;      -- 

17. 按课程分组排名   
SELECT        
c.course_name,       
s.name,       
sc.score,       
RANK() OVER (PARTITION BY sc.course_id ORDER BY sc.score DESC) AS course_rank   
FROM scores sc   
JOIN students s ON sc.student_id = s.student_id   
JOIN courses c ON sc.course_id = c.course_id   
ORDER BY c.course_id, course_rank;      -- 

18. 高于平均分的学生   
SELECT        
s.name,       
sc.score   FROM students s   
JOIN scores sc ON s.student_id = sc.student_id   
WHERE sc.score > (SELECT AVG(score) FROM scores);      --

 19. 成绩分布统计   SELECT        
CASE            
WHEN score >= 90 THEN 'A (90-100)'           
WHEN score >= 80 THEN 'B (80-89)'           
WHEN score >= 70 THEN 'C (70-79)'           
WHEN score >= 60 THEN 'D (60-69)'           
ELSE 'F (<60)'       
END AS Grade,       
COUNT(*) AS Student_Count   
FROM scores   
GROUP BY        
CASE            
WHEN score >= 90 THEN 'A (90-100)'           
WHEN score >= 80 THEN 'B (80-89)'           
WHEN score >= 70 THEN 'C (70-79)'           
WHEN score >= 60 THEN 'D (60-69)'           
ELSE 'F (<60)'       
END   ORDER BY Grade;   

20. 最近一次考试的成绩
SELECT    
s.name AS Student,
c.course_name AS Course,    
sc.score AS Score,       
sc.exam_date AS Exam_Date   FROM scores sc   
JOIN students s ON sc.student_id = s.student_id   
JOIN courses c ON sc.course_id = c.course_id   
WHERE sc.exam_date = (SELECT MAX(exam_date) FROM scores)   
ORDER BY s.name;
