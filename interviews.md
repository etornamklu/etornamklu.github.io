---
layout: default
title: Interviews
---

# Interviews

Head First books were my first introduction to programming. Head First HTML came first, then Python, JavaScript, Go, SQL. I've worked through a lot of them and they remain some of the best technical books I've read.

One thing they do that has always stuck with me is interview concepts as if they were people. Each concept gets a personality, a perspective, and occasionally some beef with the others. It makes abstract ideas feel like characters, which makes it much easier to remember when and why to use one over the other.

The posts here are my attempt at that format.

---

{% for post in site.categories.interviews %}
  <div>
    <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </div>
{% endfor %}
