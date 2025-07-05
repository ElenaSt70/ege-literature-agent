import json
import random

def load_tasks(filename="tasks.json"):
    with open(filename, encoding="utf-8") as f:
        return json.load(f)

def filter_tasks(tasks, topic=None, year=None, number=None):
    filtered = [
        task for task in tasks
        if (not topic or task["topic"] == topic)
        and (not year or task["year"] == year)
        and (not number or task["number"] == number)
    ]
    return filtered

def generate_task(topic=None, year=None, number=None):
    tasks = load_tasks()
    filtered = filter_tasks(tasks, topic, year, number)
    if not filtered:
        return "Нет заданий, соответствующих выбранным параметрам."
    return random.choice(filtered)["task"]

if __name__ == "__main__":
    print("Пример 1:", generate_task())
    print("Пример 2:", generate_task(topic="лирика"))
    print("Пример 3:", generate_task(year=2023, number=8))
