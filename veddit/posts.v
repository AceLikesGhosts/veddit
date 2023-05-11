module veddit

import net.http { get }
import json

pub fn user_posts_a(name string) !Posts {
	return generic_posts('https://reddit.com/user/', name, '', 25, '', '')
}

pub fn user_posts_b(name string, limit int) !Posts {
	return generic_posts('https://reddit.com/user/', name, '', limit, '', '')
}

pub fn user_posts_c(name string, limit int, after string) !Posts {
	return generic_posts('https://reddit.com/user/', name, '', limit, after, '')
}

// Wrapper for the base <code>generic_posts</code> function, that allows for passing less parameters.
// Defaults to 25 limit, with no after.
pub fn subreddit_posts_a(name string, sort string) !Posts {
	return generic_posts('https://reddit.com/r/', name, sort, 25, '', '')
}

// Wrapper for the base <code>generic_posts</code> function, that allows for passing less parameters.
// Defaults to no after.
pub fn subreddit_posts_b(name string, sort string, limit int) !Posts {
	if limit > 100 {
		return error("Reddit only allows for pulling 100 posts (limit),
		for more options try using 'after' with the last post ID.")
	}

	return generic_posts('https://reddit.com/r/', name, sort, limit, '', '')
}

// Wrapper for the base <code>generic_posts</code> function, that allows for passing less parameters.
// Defaults to no before.
pub fn subreddit_posts_c(name string, sort string, limit int, after string) !Posts {
	return generic_posts('https://reddit.com/r/', name, sort, limit, after, '')
}

// Fetches data from either a subreddit or user page with the name, sort (type), limit, and after.
// After allows for paging, and pulling more data.
pub fn generic_posts(url string, name string, sort string, limit int, after string, before string) !Posts {
	if !url.starts_with('https://reddit.com/') {
		return error('URL link passed to `generic_posts` must start with `https://reddit.com/`')
	}

	valid_str('url', url)!
	valid_str('name', name)!
	valid_str('sort', sort)!
	valid_str('after', after)!
	valid_str('before', before)!

	if limit < 1 {
		return error('Cannot limit to less than 1 post.')
	}

	if limit > 100 {
		return error("Reddit only allows for pulling 100 posts (limit),
		for more options try using 'after' with the last post ID.")
	}

	sort_lower := sort.to_lower()
	mut resp := get('${url}${name}/${sort}.json?after=${after}&limit=${limit}&before=${before}') or {
		return error('Failed to get subreddit ${name} (${url}${name}/${sort_lower}.json?limit=${limit}&after=${after}&before=${before}).\nOriginal: ${err}')
	}

	return json.decode(Posts, resp.body)
}

//#region HELL

/**
* Are there actual posts?
*/
pub fn (posts &Posts) is_empty() bool {
	return !(posts.data.children.len > 0)
}

struct Posts {
pub:
	data PostData
	kind Kind
}

struct PostData {
pub:
	after      string
	before     string
	children   []PostChildren
	dist       int
	geo_filter string
	mod_hash   string         [json: 'modhash']
}

struct PostChildren {
pub:
	data PostChild
	kind Kind
}

struct PostChild {
pub:
	all_awardings                 []PostAward
	allowed_live_comments         bool
	approved_at_utc               int
	approved_by                   string
	archived                      bool
	author                        string
	author_flair_background_color string
	author_flair_css_class        string
	author_flair_richtext         string
	author_flair_template_id string
	author_flair_text        string
	author_flair_text_color  string
	author_fullname          string
	author_is_blocked        bool
	author_patreon_flair     bool
	author_premium           bool
	// TODO: find type
	// awarders                      map[string]string
	banned_at_utc int
	banned_by     string
	can_gild      bool
	can_mod_post  bool
	// TODO: find type
	// category                      []string
	contest_mode bool
	created      int
	created_utc  int
	// TODO: find type
	// discussion_type               string
	// TODO: find type
	distinguished                 string
	domain string // what?
	downs  int
	edited bool
	gilded int
	// TODO: find type
	// gildings                      map[string]string
	hidden                 bool
	hide_score             bool
	id                     string
	is_created_from_ads_ui bool
	is_crosspostable       bool
	is_meta                bool
	is_original_content    bool
	is_reddit_media_domain bool
	is_robot_indexable     bool
	is_self                bool
	is_video               bool
	likes                         bool
	link_flair_background_color string
	link_flair_css_class        string
	link_flair_richtext           string
	link_flair_text       string
	link_flair_text_color string
	link_flair_type       string
	locked                bool
	// TODO: find type
	// media                         map[string]string
	// TODO: find type
	// media_embed                   map[string]string
	// TODO: find type
	// media_only                    map[string]string
	mod_note         string
	mod_reason_by    string
	mod_reason_title string
	// TODO: find type
	// mod_reports                   map[string]string
	name           string
	no_follow      bool
	num_comments   int
	num_crossposts int
	num_duplicates int
	num_reports                   ?int
	over_18                 bool
	parent_whitelist_status string
	permalink               string
	pinned                  bool
	pwls                    int
	quarantine              bool
	removal_reason          string
	removed_by              string
	// TODO: find type
	// removed_by_category           map[string]string
	saved bool
	score int
	// TODO: find type
	// secure_media                  map[string]string
	// TODO: find type
	// secure_media_embed            map[string]string
	selftext                string
	selftext_html           string
	send_replies            bool
	spoiler                 bool
	stickied                bool
	subreddit               string
	subreddit_id            string
	subreddit_name_prefixed string
	subreddit_subscribers   int
	subreddit_type          string
	suggested_sort          string
	thumbnail               string
	thumbnail_height        int
	thumbnail_width         int
	title                   string
	top_awarded_type        string
	total_awards_recieved   int
	treatment_tags          []string
	ups                     int
	upvote_ratio            f64
	url                     string
	// TODO: find type
	// user_reports                  []string
	view_count       int
	visited          bool
	whitelist_status string
	// TODO: find what this means??
	wls int
}

struct PostAward {
pub:
	award_sub_type string
	award_type     string
	//  TODO: find type
	// awarding_required_to_grant_benefits int
	coin_price              int
	coin_reward             int
	count                   int
	days_of_strip_extension int
	days_of_premium         int
	description             string
	end_date                string
	giver_coin_reward       int
	icon_format             string
	icon_height             int
	icon_url                string
	icon_width              int
	id                      string
	is_enabled              bool
	is_new                  bool
	name                    string
	penny_donate            int
	penny_price             int
	start_date              string
	static_icon_height      int
	static_icon_url         string
	static_icon_width       int
	sticky_duration_seconds int
	subreddt_coin_reward    int
	subreddit_id            string
	// TODO: find type
	// tiers_by_required_awardings         []string
}

//#endregion
