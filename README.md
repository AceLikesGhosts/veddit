# veddit
> a simplistic reddit wrapper for V

### installation
this project is listed on [vpm](https://vpm.vlang.io) meaning you are able to pull it into
your workspace by simply running `v install acelikesghosts.veddit`, or you can add it
into your `v.mod` file if you'd like it to be project specific

### usage:
a few simplistic applications can be found in [the examples folder](./examples),


logging a user's about details is very easy, and can be seen here:
```v
module main

import acelikesghosts.veddit

fn main() {
    about := veddit.about_user('acelikesaudio')!
    // about.whatever
    println('id: ${about.data.id}')

    // to get a user's posts, use the veddit.user_posts_a method
    posts := veddit.user_posts_a('acelikesaudio')!

    // for each child in the data's children
    // or, for each post in the array of posts (children)
    for child in posts.data.children {
        println('"${child.data.title}" at ${child.data.created_utc} UTC (${child.data.permalink})')
    }
}
```

### roadmap:
- [x] subreddit about
- [x] subreddit posts
- [x] user posts
- [x] user about

### licencing:
this project is licenced using the MIT licence, simply just because i do not care.
do what you want with this project, use it, modify it, make it your own.
