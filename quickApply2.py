from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time, random, getpass, os
from bs4 import BeautifulSoup
import datetime
import argparse
from random import randint




#STEP 1: Login 
def login(email, password):
	chromedriver = os.getcwd()+"\\"+'chromedriver.exe'
	print(chromedriver)
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
	return driver
	#element = WebDriverWait(driver, 30).until(EC.title_is("LinkedIn"))

#STEP 2: Jobs
def search(job, location,driver):
	driver.get('https://www.linkedin.com/jobs/')
	jobs_input = driver.find_element(By.XPATH, 
	             '//input[@placeholder="Search jobs by title, keyword or company"]')
	jobs_input.clear()
	jobs_input.send_keys(job)
	location_input = driver.find_element(By.XPATH, "//input[@placeholder='City, state, postal code or country']")
	location_input.clear()
	location_input.send_keys(location)
	time.sleep(1)
	location_input.send_keys(Keys.DOWN)
	location_input.send_keys(Keys.RETURN)
	try:
		location_input.send_keys(Keys.RETURN)
	except Exception:
		print("cannot press return")
#STEP 3: Navigating, filtering and appending to links.
def getOldLinks():
	oldLinks=[]
	with open(os.getcwd()+'/links.txt', 'r') as f:
		content = f.readlines()
		oldLinks = [line.split("|")[0].rstrip('\n') for line in content]
	return oldLinks

def getNewLinks(n_pages,oldLinks,driver):
	links = []
	count = 0
	while True:
		if count >= n_pages:
			break
		try:
			count += 1
			time.sleep(2)

			for _ in range(20):
				driver.execute_script("window.scrollBy(0, 300);") #This has to be done to execute the javascript and show the links hidden.
			time.sleep(1)
			#hierarchy - div[search-results-parent]->div[search-results-overlay]-ul[search-results]->li[job-listing]
			# ->span[apply-with-profile-decoration-text]
			soup = BeautifulSoup(driver.page_source, 'lxml')

			lst = soup.find('div', {'class':'search-result-item'}).find('ul').find_all('div', {'class':'job-card'})
			for item in lst:
				quick = item.find('div', {'class':'job-card__in-apply'})
				if quick:
					link = item.find('a')
					modLink = link.get('href').partition('?')[0]
					result = "https://www.linkedin.com"+modLink
					if result not in oldLinks:
						links.append(result)

			element = driver.find_element(By.XPATH, '//button[@class="next"]')
			element.click()
		except Exception as err:
			print(err)
	return links

			





#STEP 4: Visiting individual jobs and applying.
def apply(links,driver,resume):
	job_count = 0
	for link in links:
		try:
			driver.get(link)		
			time.sleep(1)
			#apply-job-button
			element = driver.find_element(By.XPATH, '//button[@class="jobs-s-apply__button js-apply-button"]')
			element.click()
			time.sleep(1)
			element = driver.find_element(By.XPATH, '//*[@id="file-browse-input"]').send_keys(resume)
			time.sleep(5)
			#send-application-button
			element = driver.find_element(By.XPATH, '//*[@class="jobs-apply-form__submit-button button-primary-large"]')
			element.click()
			time.sleep(1)
			job_count += 1
			print('JOB APPLICATIONS: ', job_count)
			randint(0,9)
		except Exception as err:
			print(err)
			continue


def main(resume=None, username='', password='', keywords='', location='', blacklist='', experience='', yes_to_all=False, store_no=False, count=False):
	print('\nWelcome to Quick Apply.\n')
	email = username
	password = password
	job = keywords
	location = location
	n_pages = count
	driver = login(username,password)
	time.sleep(3)
	search(keywords,location,driver)
	time.sleep(3)
	oldLinks = getOldLinks()
	time.sleep(3)
	links = getNewLinks(int(count),oldLinks,driver)
	time.sleep(3)
	print('\nYou have applied to {} total jobs.\n'.format(len(oldLinks)))
	print('\nYou have {} new jobs to apply.\n'.format(len(links)))
	apply(links,driver,resume)
	with open('links.txt', 'a') as f:
		for link in links:
			f.write(link+"|"+str(datetime.date.today()) +'\n')
	driver.close()

	
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Mass apply to job postings on LinkedIn")

    ## handle command line flags
    parser.add_argument(
            '--username',
            help='LinkedIn username (email address)'
        )
    parser.add_argument(
            '--password',
        )
    parser.add_argument(
            '--keywords',
            help='Keywords to search',
            required=True,
        )
    parser.add_argument(
            '--location',
            help='City to search',
            required=True,
        )
    parser.add_argument(
            '--resume',
            help='location of resume file',
        )
    parser.add_argument(
            '--blacklist',
            help='comma-seperated string of blacklisted companies',
            default=''
        )
    parser.add_argument(
            '--yes-to-all',
            help='Dont\'t ask for confirmation before appyling',
            action='store_true'
        )
    parser.add_argument(
            '--store-no',
            help='store jobid of refused jobs',
            action='store_true'
        )
    parser.add_argument(
            '--count',
            help='Number of pages',
			default=1
        )

    args = parser.parse_args()
    main(**vars(args))