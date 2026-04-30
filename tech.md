---
layout: default
title: Tech
---

# Tech

Posts about software engineering. Things I learned, things I got wrong, and things worth writing down.

---

{% for post in site.categories.tech %}
  <div>
    <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </div>
{% endfor %}