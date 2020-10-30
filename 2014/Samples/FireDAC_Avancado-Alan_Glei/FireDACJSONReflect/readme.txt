Demonstates use of Data.FireDACJSONReflect unit to pass FireDAC datasets and deltas between a DataSnap client and DataSnap REST server.

To run:

Modify ServerMethodsUnit1.FDConnectionEmployee.  This component must refer to an existing employeed.gdb file.

Run the DepartmentsServerProject.  Click "Start"

Run the DepartmentsClientProject.  
  Click "Get Departments" to display a list of department names and numbers.
  Click on a department to see department details and employees.
  Modify a value in the department details and/or employee then click "Apply Updates" to send changes to the server.
 
