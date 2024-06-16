-- Active: 1711696967223@@127.0.0.1@3306@media_outlet
/* create and use database */
CREATE DATABASE media_outlet;
USE media_outlet;

/* info */
CREATE TABLE self (
    StudID VARCHAR(10) NOT NULL UNIQUE,
    Department VARCHAR(10) NOT NULL,
    SchoolYear INT DEFAULT 1,
    Name VARCHAR(10) NOT NULL,
    PRIMARY KEY (StudID)
);

INSERT INTO self
VALUES ('z55555555', 'Politics', 3, 'John');

SELECT DATABASE();
SELECT * FROM self;

/* create table */
CREATE TABLE article (
    article_id VARCHAR(10) NOT NULL UNIQUE,
    article_type ENUM('report', 'opinion'),
    title VARCHAR(100) NOT NULL,
    content VARCHAR(500) NOT NULL,
    date_published DATETIME NOT NULL,
    unique_views INT NOT NULL DEFAULT 0,
    comment_amount INT DEFAULT 0,
    engagment INT CHECK (engagment BETWEEN 1 AND 10),
    word_count INT NOT NULL DEFAULT 0,
    PRIMARY KEY (article_id)
);

CREATE TABLE report (
    report_id VARCHAR(10),
    source VARCHAR(50),
    FOREIGN KEY (report_id) REFERENCES article(article_id),
    PRIMARY KEY (report_id)    
);

CREATE TABLE opinion (
    opinion_id VARCHAR(10),
    opinion_sentiment VARCHAR(255),
    FOREIGN KEY (opinion_id) REFERENCES article(article_id),
    PRIMARY KEY (opinion_id)    
);

CREATE TABLE topic (
    topic_id VARCHAR(10) NOT NULL UNIQUE,
    topic_name VARCHAR(255),
    popularity INT CHECK (popularity BETWEEN 1 AND 5),
    target_audience VARCHAR(50) CHECK (target_audience IN ('children', 'teenager', 'young_adult', 'adult', 'senior')),
    PRIMARY KEY (topic_id)
);

CREATE TABLE article_topic (
    article_id VARCHAR(10),
    topic_id VARCHAR(10),
    FOREIGN KEY (article_id) REFERENCES article(article_id),
    FOREIGN KEY (topic_id) REFERENCES topic(topic_id),
    PRIMARY KEY (article_id, topic_id)
);

CREATE TABLE international (
    int_topic_id VARCHAR(10),
    country VARCHAR(50),
    FOREIGN KEY (int_topic_id) REFERENCES topic(topic_id),
    PRIMARY KEY (int_topic_id, country)
);

CREATE TABLE domestic (
    dom_topic_id VARCHAR(10),
    region VARCHAR(50),
    FOREIGN KEY (dom_topic_id) REFERENCES topic(topic_id),
    PRIMARY KEY (dom_topic_id, region)
);

CREATE TABLE sports (
    sport_topic_id VARCHAR(10),
    sport VARCHAR(50),
    event VARCHAR(50),
    FOREIGN KEY (sport_topic_id) REFERENCES topic(topic_id),
    PRIMARY KEY (sport_topic_id, sport, event)
);

CREATE TABLE economy (
    econ_topic_id VARCHAR(10),
    industry VARCHAR(50),
    FOREIGN KEY (econ_topic_id) REFERENCES topic(topic_id),
    PRIMARY KEY (econ_topic_id, industry)
)

CREATE TABLE author (
    author_id INT AUTO_INCREMENT NOT NULL UNIQUE,
    article_count INT DEFAULT 0,
    full_name VARCHAR(50) NOT NULL,
    publication_frequency FLOAT DEFAULT 0,
    PRIMARY KEY (author_id) 
);

CREATE TABLE author_article (
    author_id INT,
    article_id VARCHAR(10),
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (article_id) REFERENCES article(article_id), 
    PRIMARY KEY (author_id, article_id)

);

CREATE TABLE contributor (
    contributor_id INT,
    organization VARCHAR(50),
    tenure VARCHAR(50),
    research VARCHAR(50),
    FOREIGN KEY (contributor_id) REFERENCES author(author_id),
    PRIMARY KEY (contributor_id)
);

CREATE TABLE fields_of_expertise (
    contributor_id INT,
    field VARCHAR(50),
    FOREIGN KEY (contributor_id) REFERENCES contributor(contributor_id),
    PRIMARY KEY (contributor_id, field)
);

CREATE TABLE journalist (
    journalist_id INT,
    eic_id INT,
    FOREIGN KEY (journalist_id) REFERENCES author(author_id),
    FOREIGN KEY (eic_id) REFERENCES journalist(journalist_id),
    PRIMARY KEY (journalist_id)
);

CREATE TABLE areas_of_coverage (
    journalist_id INT,
    area VARCHAR(50),
    FOREIGN KEY (journalist_id) REFERENCES journalist(journalist_id),
    PRIMARY KEY (journalist_id, area)
);

CREATE TABLE user (
    user_id VARCHAR(10) NOT NULL UNIQUE,
    is_registered BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (user_id)
);

CREATE TABLE registered (
    user_id VARCHAR(10),
    nickname VARCHAR(50) NOT NULL,
    gender ENUM('male','female','other'),
    registration_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    PRIMARY KEY (user_id)
);

CREATE TABLE guest (
    user_id VARCHAR(10),
    last_interaction DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    PRIMARY KEY (user_id)
);

CREATE TABLE interactions (
    interaction_id VARCHAR(10) NOT NULL UNIQUE,
    user_id VARCHAR(10) NOT NULL,
    inter_time DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    PRIMARY KEY (interaction_id)

);

CREATE TABLE comment (
    comment_id VARCHAR(10),
    content VARCHAR(250) NOT NULL,
    sentiment ENUM('positive','negative','neutral'),
    FOREIGN KEY (comment_id) REFERENCES interactions(interaction_id),
    PRIMARY KEY (comment_id)
);

CREATE TABLE view (
    view_id VARCHAR(10),
    is_unique BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (view_id) REFERENCES interactions(interaction_id),
    PRIMARY KEY (view_id)
);

CREATE TABLE interactions_article (
    interaction_id VARCHAR(10),
    article_id VARCHAR(10),
    FOREIGN KEY (interaction_id) REFERENCES interactions(interaction_id),
    FOREIGN KEY (article_id) REFERENCES article(article_id),
    PRIMARY KEY (interaction_id, article_id)
);
/* insert */
INSERT INTO article 
VALUES
('ART001', 'report', 'Taiwans Economic Outlook: Challenges and Opportunities', 'Analyzing the current state of Taiwans economy and exploring potential paths for growth.', '2024-03-15', 1500, 50, 8, 1200),
('ART002', 'report', 'Baseball Fever: The Excitement of the World Series', 'Recapping the thrilling moments of the recent World Series baseball game.', '2024-03-20', 1800, 65, 7, 950),
('ART003', 'opinion', 'U.S.-China Relations: A New Chapter?', 'Examining recent developments and tensions in the relationship between the United States and China.', '2024-03-25', 1200, 40, 9, 800),
('ART004', 'opinion', 'Domestic Developments in Taipei: A Closer Look', 'Exploring the latest domestic news and developments in Taipei, covering various aspects such as infrastructure, economy, and culture.', '2024-03-30', 2000, 80, 6, 1100)
;

INSERT INTO report 
VALUES
('ART001', 'BBC'),
('ART002', 'CNN')
;

INSERT INTO opinion 
VALUES
('ART003', 'neutral'),
('ART004', 'neutral')
;

INSERT INTO topic
VALUES
('TOP001', 'Taiwan economy', 3, 'adult'),
('TOP002', 'World series', 5, 'teenager'),
('TOP003', 'U.S.-China Relations', 3, 'adult'),
('TOP004', 'Taipei News', 4, 'adult')
;

INSERT INTO article_topic
VALUES
('ART001', 'TOP001'), 
('ART002', 'TOP002'), 
('ART003', 'TOP003'), 
('ART004', 'TOP004')
;

INSERT INTO international
VALUES 
('TOP003', 'China'),  
('TOP003', 'U.S.'),
('TOP002', 'U.S.')
; 

INSERT INTO domestic
VALUES     
('TOP004', 'Taipei')
;   

INSERT INTO sports
VALUES 
('TOP002', 'Baseball', 'World Series')
;

INSERT INTO economy
VALUES 
('TOP001', 'Various'),  
('TOP004', 'Various')
;

INSERT INTO author (article_count, full_name, publication_frequency) 
VALUES
(10, 'Emily Smith', 2.5),
(5, 'John Lai', 1.8),
(7, 'John Smith', 3.2),
(3, 'Emily Johnson', 4.5),
(0, 'Michael Brown', 0)
;

INSERT INTO author_article
VALUES
('1','ART001'),
('2','ART002'),
('3','ART003'),
('4','ART004')
;

INSERT INTO contributor
VALUES 
(3, 'Foreign Policy Institute', '5 years', 'Political Science'),
(4, 'Asian-U.S. Economic Association', '3 years', 'Economics'),
(5, 'Technology Company', '7 years', 'Artificial Intelligence')
;

INSERT INTO fields_of_expertise
VALUES 
(3, 'Politics'),
(3, 'Society'),
(4, 'Economics'),
(4, 'Politics'),
(5, 'Artificial Intelligence'),
(5, 'Machine Learning')
;

INSERT INTO journalist
VALUES
(1, NULL),
(2, 1)
;  

INSERT INTO areas_of_coverage
VALUES
(1, 'Politics'),
(1, 'Economy'),
(1, 'Technology'),
(1, 'Environment'),
(2, 'Health'),
(2, 'Baseball'),
(2, 'Football')
;

INSERT INTO user
VALUES
('user001', TRUE),
('user002', FALSE),
('user003', TRUE)
;

INSERT INTO registered
VALUES
('user001', 'Explorer1', 'male', '2024-03-01'),
('user003', 'Adventurer3', 'other', '2024-03-15')
;

INSERT INTO guest
VALUES ('user002', '2024-03-25')
;

INSERT INTO interactions
VALUES
('INT001', 'user001', '2024-03-20 08:30:00'),
('INT002', 'user002', '2024-03-21 12:45:00'),
('INT003', 'user003', '2024-03-22 17:20:00')
;

INSERT INTO comment
VALUES 
('INT001', 'Great article, very informative!', 'positive'),
('INT003', 'This article lacks depth and analysis.', 'negative')
;

INSERT INTO view
VALUES 
('INT002', FALSE)
;

INSERT INTO interactions_article
VALUES 
('INT001', 'ART001'),
('INT002', 'ART002'),
('INT003', 'ART003')
;

/* creating two views */
CREATE VIEW topic_of_articles AS
SELECT a.article_id, a.title, a.content, t.topic_name
FROM article AS a
JOIN article_topic AS at ON a.article_id = at.article_id
JOIN topic AS t ON at.topic_id = t.topic_id
;
CREATE VIEW authors_of_articles AS
SELECT at.full_name AS author_name, a.article_id, a.title, a.content
FROM article AS a
JOIN author_article AS aa ON a.article_id = aa.article_id
JOIN author AS at ON aa.author_id = at.author_id
;
/* select from all tables and views */
SELECT * FROM article;
SELECT * FROM report;
SELECT * FROM opinion;
SELECT * FROM topic;
SELECT * FROM article_topic;
SELECT * FROM international;
SELECT * FROM domestic;
SELECT * FROM sports;
SELECT * FROM economy;
SELECT * FROM author;
SELECT * FROM author_article;
SELECT * FROM contributor;
SELECT * FROM fields_of_expertise;
SELECT * FROM journalist;
SELECT * FROM areas_of_coverage;
SELECT * FROM user;
SELECT * FROM registered;
SELECT * FROM guest;
SELECT * FROM interactions;
SELECT * FROM comment;
SELECT * FROM view;
SELECT * FROM interactions_article;
SELECT * FROM topic_of_articles;
SELECT * FROM authors_of_articles;

/***** homework commands *****/

/* basic select */
SELECT *
FROM author
WHERE (NOT article_count = 0) AND
    (article_count > 7 OR (publication_frequency > 3))
;

/* basic projection */
SELECT topic_name, popularity
    FROM topic
;

/* basic rename */
ALTER TABLE interactions
RENAME COLUMN
inter_time TO interaction_time
;

/* union */
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (4,2), (3,4);
CREATE TABLE t2 (a INT, b INT);
INSERT INTO t2 VALUES (1,2), (3,4);

SELECT a, b FROM t1
UNION
SELECT a, b FROM t2
;

SELECT a, b FROM t1
INTERSECT
SELECT a, b FROM t2
;

SELECT a, b FROM t1
EXCEPT
SELECT a, b FROM t2
;

/* equijoin */
SELECT a.full_name, a.article_count, a.publication_frequency
FROM author AS a
JOIN contributor AS c ON
    a.author_id = c.contributor_id
;

/* natural join */
SELECT *
FROM contributor
NATURAL JOIN fields_of_expertise
;

/* theta join */
SELECT DISTINCT (r.user_id), r.nickname, r.registration_date
FROM registered AS r
JOIN interactions AS i ON
i.interaction_time > r.registration_date
;

/* three table join */
SELECT a.article_id, a.title, c.content, c.sentiment
FROM article AS a
NATURAL JOIN interactions_article AS ia
JOIN comment AS c ON ia.interaction_id = c.comment_id AND c.sentiment = 'positive'
;

/* aggregate */
SELECT article_type, COUNT(title), MAX(unique_views), MIN(comment_amount) 
FROM article
GROUP BY article_type
;

/* aggregate 2 */
SELECT article_type, COUNT(title), SUM(unique_views), AVG(comment_amount) 
FROM article
GROUP BY article_type
HAVING SUM(unique_views) > 3200
;

/* in */
SELECT DISTINCT a.full_name, ar.area
FROM areas_of_coverage AS ar
JOIN author AS a ON a.author_id = ar.journalist_id
WHERE ar.area IN ('Politics', 'Environment')
;

/* in 2 */
SELECT full_name, publication_frequency
FROM author
WHERE full_name IN (
    SELECT at.full_name
    FROM article AS a
    JOIN author_article AS aa ON a.article_id = aa.article_id
    JOIN author AS at ON aa.author_id = at.author_id
    WHERE a.unique_views > 1600
)
;
/* correlated nested query */
SELECT a.article_id, a.title, o.opinion_sentiment
FROM article AS a
JOIN opinion AS o ON a.article_id = o.opinion_id
WHERE a.article_id IN (
    SELECT at.article_id
    FROM article_topic AS at
    WHERE at.topic_id IN (
        SELECT at2.topic_id
        FROM article_topic AS at2
        WHERE at2.article_id = a.article_id
    )
)
;

/* correlated nested query 2 */
SELECT a.author_id, a.full_name
FROM author a
WHERE EXISTS (
    SELECT *
    FROM journalist AS j
    JOIN author_article AS aa ON j.journalist_id = aa.author_id
    JOIN report AS r ON aa.article_id = r.report_id
    WHERE j.journalist_id = a.author_id
)
;

/* correlated nested query 3 */
SELECT t.topic_id, t.topic_name
FROM topic AS t
WHERE NOT EXISTS (
    SELECT 1
    FROM fields_of_expertise AS fe
    WHERE fe.contributor_id = t.topic_id
)
;

/* bonus 1 */
CREATE TABLE student(ID INT, YEAR INT);
INSERT INTO student VALUES (11, 3),
(12,3), (13,4), (14,4);
CREATE TABLE staff(ID INT, RANKING INT);
INSERT INTO staff VALUES (15,22),
(16,23);

SELECT s.ID, s.YEAR, st.RANKING
FROM student AS s
LEFT OUTER JOIN staff AS st ON s.ID = st.ID
UNION
SELECT st.ID, s.YEAR, st.RANKING
FROM staff AS st
LEFT OUTER JOIN student AS s ON s.ID = st.ID
;

/* bonus 2 */
SELECT st.ID, s.YEAR, st.RANKING
FROM staff AS st
LEFT OUTER JOIN student AS s ON s.ID = st.ID
;
/* drop database */
DROP DATABASE media_outlet;