import matplotlib.pyplot as plt
import numpy as np
import psycopg2
import os

def connect_and_export():
    # Connect to an existing database
    conn = psycopg2.connect(dbname=os.environ["POSTGRES_DB_NAME"],user=os.environ["POSTGRES_USERNAME"], password=os.environ["POSTGRES_PASSWORD"],host=os.environ["POSTGRES_HOSTNAME"], options=f"-c search_path={os.environ['POSTGRES_SCHEMA_NAME']}")

    # Open a cursor to perform database operations
    cur = conn.cursor()

    # Execute a command: this creates a new table
    cur.execute(f"select table_name from information_schema.tables where table_schema='{os.environ['POSTGRES_SCHEMA_NAME']}';")
    for row in cur.fetchall():
        table_name=row[0]
        print(f"Generating image from {table_name}")
        file_name=f"target/images/{table_name}.png"
        cur.execute(f"SELECT x,y,colour FROM {table_name} order by x,y;")
        numpy_array = np.array(cur.fetchall())
        generate_image_file(numpy_array,file_name,False)


def generate_image_file(numpy_array,file_path,show_grid):
    x=numpy_array[:, 0]
    width=len(np.unique(x))
    y=numpy_array[:, 1]
    height=len(np.unique(y))
    c=numpy_array[:, 2]
    major_tick_interval = 50
    minor_tick_interval = 10

    fig, ax = plt.subplots()
    ax.scatter(x, y, c=c, alpha=1,marker="s",linewidths=0)
    ax.set_xlim((0,width))
    ax.set_ylim((0,height))
    x0,x1 = ax.get_xlim()
    y0,y1 = ax.get_ylim()
    ax.set_aspect(abs(x1-x0)/abs(y1-y0))

    if show_grid:
        major_ticks = np.arange(0, max([width,height]), major_tick_interval)
        minor_ticks = np.arange(0, max([width,height]), minor_tick_interval)
        ax.set_xticks(major_ticks)
        ax.set_xticks(minor_ticks, minor=True)
        ax.set_yticks(major_ticks)
        ax.set_yticks(minor_ticks, minor=True)
        # And a corresponding grid
        ax.grid(which='minor', alpha=0.2)
        ax.grid(which='major', alpha=0.5)
    else:
        ax.grid(False)
        # Hide axes ticks
        ax.set_xticks([])
        ax.set_yticks([])
    fig.savefig(file_path, dpi=200,bbox_inches='tight')
    plt.close(fig)

connect_and_export()