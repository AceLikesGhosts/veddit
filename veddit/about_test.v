module veddit

import net.http { get }
import json

// test_user this is such a bad test. but like, it works? ig.
fn test_about_user() {
	mut resp := get('https://reddit.com/user/reddit/about.json')!
	our_user := json.decode(User, resp.body)!

	mut fetched_user := about_user('admin')!
	assert our_user == fetched_user

	assert fetched_user.kind == 't2' // t2 means its a user

	assert fetched_user.data.created_utc == 1134104400
	assert fetched_user.data.created == 1134104400

	assert fetched_user.data.is_employee == true
	assert fetched_user.data.is_mod == true
	assert fetched_user.data.is_gold == true

	assert fetched_user.data.accept_chats == false
	assert fetched_user.data.accept_pms == true
	assert fetched_user.data.accept_followers == true
}
