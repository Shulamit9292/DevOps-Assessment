# Extract Bash Script



This script is called `extract.sh`, and it can unpack multiple packed files. It is capable of traversing folders recursively and unpacking all archives in them, regardless of the specific algorithm used when packing them.

## Location in the project:
scripts/extract.sh


## Synopsis

```bash

extract [-h] [-r] [-v] file [file...]
```


# Features

- Automatically detects the compression method used on the file by parsing the output of the `file` command.

- Supports 4 unpacking options:

    - `gunzip`

    - `bunzip2`

    - `unzip`

    - `uncompress`

- Handles both individual files and directories:

    - If the target is a file, the script will try to extract it using the appropriate method.

    - If the target is a directory, the script will recursively decompress all files within it.

- If a file is not compressed, no action will be taken on that file.

- Overwrites existing files with the same name.



# Command Line Options

### `-v` (Verbose)

- Enables verbose mode.

- The script will print the name of each file it decompresses.

- It will also warn for each file that it cannot decompress.



### `-r` (Recursive)

- Enables recursive mode.

- This will allow the script to traverse directories and decompress files inside them.



### `-h` (Help)

- Displays a help message with instructions on how to use the script.



# How to Use

1. **Make the script executable**:

   Run the following command to make the script executable:

   ```bash

   chmod +x extract.sh

```
 

2. **Run the script**: 

   To extract one or more files, simply run:

   ```bash

   ./extract.sh file1 file2 file3
```



# 3. Using the Recursive Mode

To extract all files in a directory and its subdirectories, use the `-r` flag:

```bash

./extract.sh -r /path/to/directory
```



# 4. Using Verbose Mode

To enable verbose output (see each file being decompressed and warnings), use the `-v` flag:



```bash

./extract.sh -v file1 file2 file3
```



# 5. Display Help

To view the help message with all available options, use the `-h` flag:



```bash

./extract.sh -h
```



# Example Usage



## Extract a single file:

To extract a single file, run the following command:



```bash

./extract.sh /workspace/test_files/sample.zip
```


## Extract multiple files:

To extract multiple files, run the following command:



```bash

./extract.sh /workspace/test_files/sample1.gz /workspace/test_files/sample2.bz2
```



## Extract all files in a directory recursively:

To extract all files in a directory and its subdirectories, use the `-r` flag:



```bash

./extract.sh -r /workspace/test_files/
```





## Extract files with verbose output:

To extract files and see verbose output (showing each file being decompressed and any warnings), use the `-v` flag:



```bash

./extract.sh -v /workspace/test_files/sample.zip
```





## Notes

- If a file is not compressed, the script will not take any action on it.

- The script will overwrite files in the destination directory if files with the same name exist.