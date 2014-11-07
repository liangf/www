import csv
import sys

from facepy import GraphAPI

access_token = "CAACEdEose0cBAOGb8xQKDDGt9mEQ9qZCCsYxcSb0uZC3VkWmh27814iyhGgRLSFyL6D5jVB6d6zZBRBsmCjFtZCfua4zLNwi7sQZCD47nPNLn1nK0r6WXaHeFCx2CSXcZCAe6qbw68ZBWvzzEmHZCCR30kdoA6XGB2rk8NOZBRmOjyJBJ2UEJsMUYuyV5rPZCKZAtkZD";
graph = GraphAPI(access_token)

#writer = csv.writer(sys.stdout)


# Make a FQL query
#g = graph.fql('SELECT name FROM user WHERE uid = me()')

# Make a FQL multiquery
g = graph.fql({
	'link_status': 'SELECT comments_fbid FROM link_stat WHERE url = "www.liangfang.us/test/test.html"',
    'likes': 'SELECT user_id FROM like WHERE object_id IN (SELECT comments_fbid FROM #link_status)',
	'users': 'SELECT name, profile_url FROM user WHERE uid IN (SELECT user_id FROM #likes)'
          })

#print g['data'][2]
users = g['data'][2]


csvfile = file('all_user.csv', 'wb')
writers = csv.writer(csvfile)
#writers.writerow(['profile_url'])


#print users['fql_result_set']
for user in users['fql_result_set']:
	print user['profile_url']
	writers.writerow([user['profile_url']])


