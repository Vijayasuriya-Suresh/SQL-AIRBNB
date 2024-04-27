import json
from CSV_To_SQL_Engine import CompressedCSV2SQL

# load configurations for sql
with open('sql_configs.json', 'r') as config_file:
    configs = json.load(config_file)

DATABASE_URL = configs['DATABASE_URL']
PASSWORD = configs['SQL_PASSWORD']


if __name__ == '__main__':
    # define database name
    # (make sure that a database of this name exists in your MySQL server)
    database_name = 'rome_airbnb_listings'
    # construct database url from configurations
    database_url = f'mysql://root:{PASSWORD}{DATABASE_URL}/{database_name}'

    # create engine to decompress CSV and load to SQL
    To_SQL_Engine = CompressedCSV2SQL(database_url=database_url)
    # do the decompression and loading to SQL
    To_SQL_Engine.decompress_and_load_to_sql(
        compressed_csv_filepath='rome_listings.csv',
        table_name='rome_listings'
    )

    print('done loading to sql')
