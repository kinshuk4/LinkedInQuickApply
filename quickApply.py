from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time, random, getpass, os
from bs4 import BeautifulSoup

print('\nWelcome to AutoQuickApply by Tomas Silva Ebensperger.\n')
email = input('Enter email    | ')
password = getpass.getpass('Enter password | ')
job = input('Job keywords   | ')
location = input('Job location   | ')
phone_num = input('Phone number   |')
n_pages = int(input('Page limit     | '))

#STEP 1: Login 
chromedriver = os.getcwd()+'/chromedriver'
chrome_options = webdriver.ChromeOptions()
prefs = {"profile.default_content_setting_values.notifications" : 2}
chrome_options.add_experimental_option("prefs",prefs)
driver = webdriver.Chrome(chromedriver, chrome_options=chrome_options)
# driver = webdriver.PhantomJS()
driver.get('https://www.linkedin.com/uas/login')
element = driver.find_element_by_id('session_key-login')
element.send_keys(email)
element = driver.find_element_by_id('session_password-login')
element.send_keys(password)
element.submit()
element = WebDriverWait(driver, 10).until(EC.title_is("LinkedIn"))

#STEP 2: Jobs
driver.get('https://www.linkedin.com/jobs/')
jobs_input = driver.find_element(By.XPATH, "//input[@placeholder='Search jobs by title, keyword or company']")
jobs_input.clear()
jobs_input.send_keys(job)
location_input = driver.find_element(By.XPATH, "//input[@placeholder='City, state, postal code or country']")
location_input.clear()
location_input.send_keys(location)
time.sleep(1)
location_input.send_keys(Keys.DOWN)
location_input.send_keys(Keys.RETURN)

#STEP 3: Navigating, filtering and appending to links.
links = []
count = 0
with open(os.getcwd()+'/links.txt', 'r') as f:
	content = f.readlines()
	oldLinks = [line.rstrip('\n') for line in content]

while True:
	if count >= n_pages:
		break
	try:
		count += 1
		time.sleep(2)
		for _ in range(20):
			driver.execute_script("window.scrollBy(0, 300);") #This has to be done to execute the javascript and show the links hidden.
		time.sleep(1)
		soup = BeautifulSoup(driver.page_source, 'lxml')
		lst = soup.find('div', {'class':'jobs-search-results'}).find('ul').find_all('div', {'class':'occludable-update card-list__item job-card job-card--column ember-view'})

		for item in lst:
			quick = item.find('p', {'class':'job-card__in-apply-text'})
			if quick:
				link = item.find('a')
				modLink = link.get('href').partition('?')[0]
				result = 'https://www.linkedin.com'+modLink
				if result not in oldLinks:
					links.append(result)

		element = driver.find_element_by_css_selector('button.next')
		element.click()
	except Exception:
		break
with open('links.txt', 'a') as f:
	for link in links:
		f.write(link+'\n')
print('\nYou have applied to {} total jobs.\n'.format(len(oldLinks)))
print('\nYou have {} new jobs to apply.\n'.format(len(links)))

#STEP 4: Visiting individual jobs and applying.
job_count = 0
for link in links:
	try:
		driver.get(link)		
		time.sleep(1)
		element = driver.find_element_by_css_selector('button.jobs-s-apply__button.js-apply-button')
		element.click()
		time.sleep(1)
		element = driver.find_element_by_id('apply-form-phone-input')
		element.send_keys(phone_num)
		element = driver.find_element(By.XPATH, '//*[@id="file-browse-input"]').send_keys(os.getcwd()+'/resume.pdf')
		time.sleep(5)
		element = driver.find_element_by_css_selector('button.jobs-apply-form__submit-button.button-primary-large')
		element.click()
		time.sleep(1)
		job_count += 1
		print('JOB APPLICATIONS: ', job_count)
	except Exception:
		continue

driver.close()




