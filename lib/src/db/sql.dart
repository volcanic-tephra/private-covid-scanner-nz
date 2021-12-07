const List<String> SQL = [
  """
  CREATE TABLE visit (
    id INTEGER PRIMARY KEY, 
    code TEXT, 
    name TEXT NOT NULL,
    address TEXT NOT NULL, 
    longitude TEXT, 
    latitude TEXT, 
    start_date INTEGER NOT NULL, 
    end_date INTEGER NOT NULL,
    notes TEXT,
    create_date INTEGER NOT NULL);  
  """,

  """
  CREATE TABLE passport (
    id INTEGER PRIMARY KEY,
    uuid TEXT NOT NULL,
    issued_date INTEGER NOT NULL,
    expiry_date INTEGER NOT NULL,  
    first_name TEXT NOT NULL,
    family_name TEXT NOT NULL,
    dob INTEGER NOT NULL, 
    raw TEXT NOT NULL,
    create_date INTEGER NOT NULL);  
  """,

  """
   CREATE UNIQUE INDEX idx_uuid on passport (uuid);
  """,
];