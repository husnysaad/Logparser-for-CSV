# Log Parser Script

A simple Bash script for parsing raw web server log files in CSV format and extracting structured data including the IP address, date, HTTP method, URL, protocol, and status code.

---

##  How It Works

This script takes a raw log file (CSV) with the following structure:

```
IP,Date,Request,Status
```

Each `Request` field contains a string like `GET /index.html HTTP/1.1`. The script extracts:

- **IP** — Source IP address
- **Date** — Timestamp of request
- **Method** — HTTP method (e.g., GET, POST)
- **URL** — Requested resource
- **Protocol** — Protocol used (e.g., HTTP/1.1)
- **Status** — HTTP status code

It outputs a cleaned and structured CSV file with the following format:

```
IP,Date,Method,URL,Protocol,Status
```

---

##  How to Use

### Prerequisites

- A Unix-like system (Linux/macOS)
- Bash shell

### Usage

```bash
./logparser.sh raw.csv processed.csv
```

- `raw.csv` — the input file containing raw log data
- `processed.csv` — the desired name for the cleaned output file

### Example

```bash
chmod +x logparser.sh
./logparser.sh access_logs.csv cleaned_logs.csv
```

---

## Input Format Example

Your raw input file should look like:

```
IP,Date,Request,Status
192.168.1.1,2025-04-06T12:34:56,GET /index.html HTTP/1.1,200
10.0.0.1,2025-04-06T12:35:00,POST /login HTTP/2,302
```

---

##  Output Format Example

After running the script, the output CSV will look like:

```
IP,Date,Method,URL,Protocol,Status
192.168.1.1,2025-04-06T12:34:56,GET,/index.html,HTTP/1.1,200
10.0.0.1,2025-04-06T12:35:00,POST,/login,HTTP/2,302
```

---

##  Limitations

- **CSV Format Assumptions**: Assumes the input file has a header and follows the exact column structure: `IP,Date,Request,Status`.
- **No Quoted Strings Handling**: The parser doesn’t handle quoted fields or commas inside fields.
- **Basic Error Checking**: It checks for input file existence, readability, and correct extension, but doesn’t validate the contents deeply.
- **No Logging**: No separate logs are generated for parsing errors or skipped rows.
- **No Parallelism**: Processes one line at a time, which may be slower for very large files.

---

##  Exit Codes

| Code | Meaning                          |
|------|----------------------------------|
| 1    | Invalid number of arguments      |
| 2    | Input file not found             |
| 3    | Input file not readable          |
| 4    | Input file is not a CSV          |
| 5    | Output file is not a CSV         |
| 0    | Success                          |

---

