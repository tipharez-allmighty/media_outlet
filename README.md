# News Outlet Database Model

This README describes the database model for a news outlet, covering entities, relationships, and constraints for managing articles, authors, topics, interactions, and users.

## Entities and Relationships

### 1. Article

- **Primary Key**: `article_id`
- **Specialization**: 
  - **Report** 
  - **Opinion**
- **Constraints**:
  - **Total and Disjoint Specialization**: Each article must be either a Report or an Opinion, with no overlap. Articles cannot be neither.
  - **Many-to-Many Relationship**: Articles have a many-to-many (M:N) relationship with the "Topic" entity via the weak entity "article_topic." This relationship allows partial participation, meaning an article may not necessarily have a topic, and a topic can cover multiple articles.

### 2. Topic

- **Entity**: `Topic` with overlapping specialization.
- **Subclasses**:
  - **International Politics**
  - **Domestic Politics**
  - **Sports**
  - **Economics**
- **Attributes**:
  - Each subclass has multivariate attributes tailored to its domain.
- **Constraints**:
  - An article does not have to have a topic, and one topic can cover many articles. An article can also be associated with multiple topics, and a topic can cover multiple articles.

### 3. Author

- **Primary Key**: `author_id` (inherited from `contributor_id` and `journalist_id`)
- **Specialization**:
  - **Contributor**:
    - Attributes: Field of expertise, composite attribute "affiliation" (includes institutional affiliation, tenure, ongoing research)
  - **Journalist**:
    - Attributes: Areas of coverage
- **Relationships**:
  - Many-to-Many (M:N) relationship with articles. Multiple authors can contribute to multiple articles.
  - Each article requires at least one author.

### 4. Editor-in-Chief

- **Role**: Journalists can be promoted to "Editor-in-Chief."
- **Recursive Relationship**:
  - **Cardinality**: 1:N (Only one editor-in-chief is allowed at a time.)

### 5. Interaction

- **Entity**: `Interactions`
- **Subclasses**:
  - **View**
  - **Comment**
- **Key Attribute**: `interaction_id`
- **Constraints**:
  - **Total and Disjoint Specialization**: Each interaction must be either a View or a Comment. Comments imply that the article has been viewed; therefore, views and comments are mutually exclusive.

### 6. User

- **Primary Key**: `user_id`
- **Specialization**:
  - **Registered**
  - **Guest**
- **Constraints**:
  - **Total and Disjoint Specialization**: Reflects the user’s level of engagement with the platform. Even Guest users can leave comments.

### 7. Action Relationship

- **Entity**: `Action`
- **Cardinality**:
  - **1:N** (A single user can leave multiple interactions. Each interaction is associated with only one user.)

## Summary

This database model provides a comprehensive structure for managing news articles, author contributions, topic categorizations, user interactions, and engagement levels. It ensures data integrity through specialized constraints and relationships, facilitating effective data management and analysis for the news outlet.

Feel free to explore and contribute to this model by suggesting improvements or adding new features.
