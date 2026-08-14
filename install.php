<?php
require_once 'db.php';

try {
    $uploadDir = 'assets/uploads';
    if (!is_dir($uploadDir)) mkdir($uploadDir, 0777, true);

    // ১. সেটিংস
    $pdo->exec("CREATE TABLE IF NOT EXISTS settings (setting_key VARCHAR(50) PRIMARY KEY, setting_value TEXT) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    // ২. নোটিশ (BTEB Style)
    $pdo->exec("CREATE TABLE IF NOT EXISTS notices (
        id INT AUTO_INCREMENT PRIMARY KEY, 
        date VARCHAR(50), 
        category VARCHAR(50) DEFAULT 'সাধারণ', 
        title VARCHAR(255), 
        file_url VARCHAR(255), 
        isNew TINYINT(1) DEFAULT 0, 
        showInMarquee TINYINT(1) DEFAULT 0
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    // ৩. ইভেন্ট
    $pdo->exec("CREATE TABLE IF NOT EXISTS events (
        id INT AUTO_INCREMENT PRIMARY KEY, date VARCHAR(50), category VARCHAR(50), title VARCHAR(255), description TEXT, file_url VARCHAR(255), showInMarquee TINYINT(1) DEFAULT 0
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    // ৪. শিক্ষক
    $pdo->exec("CREATE TABLE IF NOT EXISTS teachers (
        id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), deg VARCHAR(100), dept VARCHAR(100), file_url VARCHAR(255)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    // ৫. কোর্স
    $pdo->exec("CREATE TABLE IF NOT EXISTS courses (
        id INT AUTO_INCREMENT PRIMARY KEY, type VARCHAR(50), title VARCHAR(255), level VARCHAR(50)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    // ৬. বাণী (প্রতিষ্ঠাতা/অধ্যক্ষ)
    $pdo->exec("CREATE TABLE IF NOT EXISTS messages (
        id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), designation VARCHAR(100), message TEXT, image_url VARCHAR(255)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    // ৭. ভর্তি আবেদন (নতুন টেবিল)
    $pdo->exec("CREATE TABLE IF NOT EXISTS admissions (
        id INT AUTO_INCREMENT PRIMARY KEY,
        student_name VARCHAR(150),
        phone VARCHAR(20),
        course_type VARCHAR(50),
        course_name VARCHAR(255),
        ssc_gpa VARCHAR(10),
        is_read TINYINT(1) DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

    echo "<h2 style='color:green; font-family:sans-serif;'>Database Updated with Admission System Successfully!</h2>";
    echo "<p style='color:red; font-family:sans-serif;'><b>Security Warning:</b> Delete this <code>install.php</code> file from your cPanel right now.</p>";

} catch (PDOException $e) {
    echo "<h2 style='color:red;'>Database Error: " . $e->getMessage() . "</h2>";
}
?>