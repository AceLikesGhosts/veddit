module main

import veddit

fn main() {
	aww_details := veddit.about_subreddit('aww')!

	println('${aww_details.data.name} was created at ${aww_details.data.created_utc}UTC')
	println('it has the description of "${aww_details.data.description}"')
}
