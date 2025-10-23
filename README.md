# TestingAssignment2

## Requirements

To run this work, you should have **Python 3.11.0 or higher** installed.  

## Setup

Clone + install

```bash
git clone https://github.com/TheILICH/TestingAssignment2.git
cd TestingAssignment2
pip install -r requirements.txt
```

### To run Login Test

```bash
cd testCases/one
robot login_test.robot
```

### To run Logout Test

```bash
cd ../two
robot logout_test.robot
```

### To run Buy Product Test

```bash
cd ../three
robot buy_test.robot
```


### To run Delete Item From Cart Test
```bash
cd ../four
robot delete_test.robot
```


## Folder Structure & Notes

- Each folder (`one`, `two`, `three`, `four`) contains:
  - The test case script (`*.robot`)
  - Test result files (`log.html`, `output.xml`, `report.html`)
  - `Screenshot_terminal.png` showing a screenshot of the successful terminal run
  - `description.txt` describing that test case
  - A `Sleep 2s` was added in the scripts for test cases three and four so that test actions remain visible long enough to verify they worked.


