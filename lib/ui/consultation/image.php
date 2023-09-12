<html>
<head>
    <title>Upload Base64 File</title>
</head>
<body>
    <form action="image.php" method="post" enctype="multipart/form-data">
        <input type="file" name="base64_file" accept=".png" />
        <input type="submit" value="Upload" />
    </form>
</body>
</html>

<?php






if ($_SERVER["REQUEST_METHOD"] == "POST") {
//    if (isset($_FILES["base64_file"]) && isset($_POST["base64_data"])) {
       $file_name = $_POST["file_name"];
        $base64_data = $_POST["base64_data"];

        // var_dump($_FILES);
        // var_dump($_POST);


        // Remove the data URI scheme (e.g., "data:image/png;base64,")
        $base64_data = preg_replace('/^data:[^,]+,/', '', $base64_data);

        // Decode the base64 data and save it to a file
        $file_contents = base64_decode($base64_data);

        if ($file_contents !== false) {
            // if (!file_exists($upload_dir)) {
            //     mkdir($upload_dir, 0777, true);
            // }
            
            $file_path = "uploads/$file_name";

            if (file_put_contents($file_path, $file_contents) !== false) {
                echo "File uploaded successfully. $file_path";
            } else {
                echo "Failed to save the file. $file_path";
            }
        } else {
            echo "Invalid base64 data.";
        }
    // } else {
    //     echo "File or base64 data not provided.";
    // }
} else {
    echo "Invalid request method.";
}
