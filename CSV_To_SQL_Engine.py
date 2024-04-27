import pandas as pd
from sqlalchemy import create_engine


class CompressedCSV2SQL:
    def __init__(self, database_url):
        self.database_url = database_url
        self.sql_engine = create_engine(database_url)

    def decompress_and_load_to_sql(self, compressed_csv_filepath, table_name, if_exists='fail', index=False):
        # decompress CSV file when reading to pandas pd.DataFrame
        df = pd.read_csv(compressed_csv_filepath, compression='gzip')
        # from pd.DataFrame, convert to sql
        df.to_sql(table_name, self.sql_engine, if_exists=if_exists, index=index)

