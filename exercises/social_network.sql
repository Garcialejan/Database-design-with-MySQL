DROP DATABASE IF EXISTS chat_room;

CREATE DATABASE chat_room;

USE chat_room;

CREATE TABLE users(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE profiles(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL, 
    user_name VARCHAR(255) UNIQUE NOT NULL,
    picture_url VARCHAR(255) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE follows(
    profile_id INT UNSIGNED NOT NULL, 
    following_profile_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (profile_id, following_profile_id) 

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    
    FOREIGN KEY (following_profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE posts(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id INT UNSIGNED NOT NULL, 
    date DATETIME NOT NULL, 
    description VARCHAR(512) NULL,

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE comments(
    profile_id INT UNSIGNED NOT NULL,
    post_id INT UNSIGNED NOT NULL,
    text VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL,

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    
    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE post_images(
    post_id INT UNSIGNED NOT NULL,
    url_image VARCHAR(255) UNIQUE NOT NULL,

    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);