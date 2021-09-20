import csv
from datetime import datetime
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager

#Set up the webdriver to scrape information from the website
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--window-size=1420,1080')
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(options=chrome_options)
driver.implicitly_wait(10)
driver.get('https://www.fitx.de/fitnessstudios/neuss-innenstadt')

code = driver.find_element_by_class_name('workload_gauge__bar_outline')
auslastung = code.get_attribute('innerHTML')

driver.quit()

# Extraxt the needed information we need, which is the width of a certain bar indicating how full the studio is
auslastung_prozent = auslastung[71:74]
auslastung_int = int(auslastung_prozent)

# Get the current date and time
now = datetime.now()
exact_time = dt_string = now.strftime("%d/%m/%Y %H:%M:%S")


# Store datetime and studio info in a list 
liste = [f'{exact_time}', f'{auslastung_int}']

# Open a .csv file and append the information to the list 
with open('auslastung.csv', 'a') as f:  
    writer = csv.writer(f)
    # write the header
    writer.writerow(liste)