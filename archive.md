---
layout: default
title: Archive
---

# All Posts

<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
      {% if post.categories %}
        <span class="post-meta">[{{ post.categories | join: ', ' }}]</span>
      {% endif %}
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>