from flask import Flask, render_template, request
import json
import random
from pathlib import Path

app = Flask(__name__)

def load_tasks(filename="tasks.json"):
    path = Path(__file__).resolve().parent / filename
    with open(path, encoding="utf-8") as f:
        return json.load(f)

def filter_tasks(tasks, topic=None, year=None, number=None):
    return [
        t for t in tasks
        if (not topic or t["topic"] == topic)
        and (not year or t["year"] == year)
        and (not number or t["number"] == number)
    ]

def generate_task(topic=None, year=None, number=None):
    tasks = load_tasks()
    filtered = filter_tasks(tasks, topic, year, number)
    if not filtered:
        return "Нет заданий, соответствующих выбранным параметрам."
    return random.choice(filtered)["task"]

@app.route("/", methods=["GET", "POST"])
def index():
    result = ""
    if request.method == "POST":
        topic = request.form.get("topic") or None
        year = request.form.get("year") or None
        number = request.form.get("number") or None

        year = int(year) if year and year.isdigit() else None
        number = int(number) if number and number.isdigit() else None

        result = generate_task(topic, year, number)

    return render_template("index.html", result=result)

if __name__ == "__main__":
    app.run(debug=True)
