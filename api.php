<?php
error_reporting(0);
ini_set('display_errors', 0);
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json; charset=utf-8');

require_once 'db.php';

$action = $_GET['action'] ?? '';

// === ফাইল আপলোড ===
if ($action === 'upload') {
    $targetDir = "assets/uploads/";
    if (!is_dir($targetDir)) mkdir($targetDir, 0777, true);
    if (isset($_FILES['file'])) {
        $file = $_FILES['file'];
        $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
        $fileName = time() . '_' . rand(1000, 9999) . '.' . $ext;
        $targetFile = $targetDir . $fileName;
        if (move_uploaded_file($file['tmp_name'], $targetFile)) {
            echo json_encode(['url' => $targetFile]);
        } else { echo json_encode(['error' => 'File upload failed.']); }
    } else { echo json_encode(['error' => 'No file uploaded']); }
    exit;
}

// === ভর্তি আবেদন সাবমিট (Website to DB) ===
if ($action === 'submit_admission') {
    $input = json_decode(file_get_contents('php://input'), true);
    if ($input) {
        $stmt = $pdo->prepare("INSERT INTO admissions (student_name, phone, course_type, course_name, ssc_gpa) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$input['name'], $input['phone'], $input['course_type'], $input['course_name'], $input['gpa']]);
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['error' => 'Invalid data']);
    }
    exit;
}

// === ভর্তি আবেদন রিড মার্ক করা (Dashboard to DB) ===
if ($action === 'mark_read') {
    $pdo->exec("UPDATE admissions SET is_read = 1 WHERE is_read = 0");
    echo json_encode(['status' => 'success']);
    exit;
}

// === ডেটা রিড (GET) ===
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $response = [];
    
    $stmt = $pdo->query("SELECT * FROM settings");
    $settings = [];
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $val = $row['setting_value'];
        if ($row['setting_key'] == 'admissionOpen') $val = (bool)$val;
        $settings[$row['setting_key']] = $val;
    }
    $response['site'] = $settings;

    $response['messages'] = $pdo->query("SELECT * FROM messages ORDER BY id ASC")->fetchAll(PDO::FETCH_ASSOC);
    $response['notices'] = $pdo->query("SELECT * FROM notices ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);
    $response['events'] = $pdo->query("SELECT * FROM events ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);
    $response['teachers'] = $pdo->query("SELECT * FROM teachers ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);
    $response['courses'] = $pdo->query("SELECT * FROM courses ORDER BY id ASC")->fetchAll(PDO::FETCH_ASSOC);
    $response['admissions'] = $pdo->query("SELECT * FROM admissions ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($response);
    exit;
} 
// === ডেটা সেভ (POST) ===
elseif ($_SERVER['REQUEST_METHOD'] === 'POST' && empty($action)) {
    $input = json_decode(file_get_contents('php://input'), true);
    if (!$input) { echo json_encode(["error" => "Invalid JSON data"]); exit; }

    try {
        $pdo->beginTransaction();

        if (isset($input['site'])) {
            $stmt = $pdo->prepare("INSERT INTO settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = ?");
            foreach ($input['site'] as $key => $value) {
                if ($key == 'admissionOpen') $value = $value ? '1' : '0';
                $stmt->execute([$key, $value, $value]);
            }
        }

        if (isset($input['messages'])) {
            $pdo->exec("DELETE FROM messages");
            $stmt = $pdo->prepare("INSERT INTO messages (name, designation, message, image_url) VALUES (?, ?, ?, ?)");
            foreach (array_reverse($input['messages']) as $m) {
                $stmt->execute([$m['name']??'', $m['designation']??'', $m['message']??'', $m['image_url']??'']);
            }
        }

        if (isset($input['notices'])) {
            $pdo->exec("DELETE FROM notices");
            $stmt = $pdo->prepare("INSERT INTO notices (date, category, title, file_url, isNew, showInMarquee) VALUES (?, ?, ?, ?, ?, ?)");
            foreach (array_reverse($input['notices']) as $n) {
                $stmt->execute([$n['date']??'', $n['category']??'সাধারণ', $n['title']??'', $n['file_url']??'', !empty($n['isNew'])?1:0, !empty($n['showInMarquee'])?1:0]);
            }
        }

        if (isset($input['events'])) {
            $pdo->exec("DELETE FROM events");
            $stmt = $pdo->prepare("INSERT INTO events (date, category, title, description, file_url, showInMarquee) VALUES (?, ?, ?, ?, ?, ?)");
            foreach (array_reverse($input['events']) as $e) {
                $stmt->execute([$e['date']??'', $e['category']??'', $e['title']??'', $e['desc']??'', $e['file_url']??'', !empty($e['showInMarquee'])?1:0]);
            }
        }

        if (isset($input['teachers'])) {
            $pdo->exec("DELETE FROM teachers");
            $stmt = $pdo->prepare("INSERT INTO teachers (name, deg, dept, file_url) VALUES (?, ?, ?, ?)");
            foreach (array_reverse($input['teachers']) as $t) {
                $stmt->execute([$t['name']??'', $t['deg']??'', $t['dept']??'', $t['file_url']??'']);
            }
        }

        $pdo->commit();
        echo json_encode(["status" => "success"]);

    } catch (Exception $e) {
        if ($pdo->inTransaction()) { $pdo->rollBack(); }
        echo json_encode(["error" => "Database Error: " . $e->getMessage()]);
    }
    exit;
}
?>