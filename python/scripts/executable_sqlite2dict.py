#!/usr/bin/env python3
import sqlite3
from collections import defaultdict
from sqlite3 import Connection, Cursor
from typing import Any


class SQLParser:
    def __init__(self, path: str) -> None:
        self.path: str = path
        self.conn: Connection = sqlite3.connect(self.path)
        self.cursor: Cursor = self.conn.cursor()
        tables: Cursor = self.cursor.execute(
            "SELECT name FROM sqlite_master WHERE type='table';"
        )
        self.tables: list[Any] = [table[0] for table in tables]

    def __enter__(self) -> "SQLParser":
        self.conn = sqlite3.connect(self.path)
        self.cursor = self.conn.cursor()
        return self

    def __exit__(self, exc_type, exc_value, traceback) -> None:
        self.conn.close()

    def __del__(self) -> None:
        print("Closing connection...")
        self.conn.close()

    def dict(self, table: str) -> dict:
        """Parse an SQL file and return a dictionary.

        Args:
        -----------
            table : str
                The name of the table to parse.
        Returns
        --------
            dict : dict
                A dictionary containing the parsed data.
        """
        # Connect to the SQLite database
        data: defaultdict[Any, list[Any]] = defaultdict(list)
        self.cursor.execute(f"SELECT * FROM {table}")
        columns: list[str | Any] = [
            description[0] for description in self.cursor.description
        ]
        for row in self.cursor.fetchall():
            data[table].append(dict(zip(columns, row, strict=False)))
        return data


def convert_sql_to_python(database_path: str) -> dict:
    """Convert an SQLite database to a Python dictionary.

    Parameters
    -----------
        database_path : str
            The path to the SQLite database file.
    """
    # Connect to the SQLite database
    db = SQLParser(database_path)

    sqldict: dict[str, list] = {}
    # Create a dictionary to hold the data

    # Fetch data from the "employees" table
    for _table in db.tables:
        sqldict[_table] = []
        db.cursor.execute(f"SELECT * FROM {_table}")

        columns: list[str | Any] = [
            description[0] for description in db.cursor.description
        ]

        for row in db.cursor.fetchall():
            sqldict[_table].append(dict(zip(columns, row, strict=False)))

    # Close the database connection
    db.__del__()

    return sqldict


def main() -> None:
    import argparse
    import json

    from rich.console import Console
    from rich.json import JSON

    parser = argparse.ArgumentParser(description="Convert an SQLite database to JSON.")
    parser.add_argument("dbpath", type=str, help="Path to the SQLite database file")
    args = parser.parse_args()

    sql_dict = convert_sql_to_python(args.database_path)
    json_output = json.dumps(sql_dict, indent=4)

    print(json_output)


if __name__ == "__main__":
    main()

# Example usage:
# database_path = 'path_to_your_database.db'
# python_data = convert_sql_to_python(database_path)
# print(python_data)
