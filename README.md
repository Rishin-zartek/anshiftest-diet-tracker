Here is your **README.md content** — structured as a **complete machine-level build prompt** for an agentic tool like Cursor.

You can directly paste this into `README.md`.

---

# 🥗 Diet Tracking App – Full Production Build Instructions

## 🔗 Design Reference (Figma)

Primary UI reference:
[https://www.figma.com/design/71LJxkmiZu1DZPToCXphsV/Nutrition-app-concept-dribbble--Community-?node-id=0-1&t=YcAMP9YT4jcPU00d-1](https://www.figma.com/design/71LJxkmiZu1DZPToCXphsV/Nutrition-app-concept-dribbble--Community-?node-id=0-1&t=YcAMP9YT4jcPU00d-1)

The UI/UX must strictly follow the Figma reference:

* Circular calorie progress
* Meal breakdown cards
* Water tracker
* Expandable meal view
* Food search screen
* Modern soft UI with green accents
* Clean typography
* Bottom navigation

---

# 🎯 PROJECT OVERVIEW

Build a **production-ready Flutter diet tracking application** with:

* Calorie tracking
* South Indian / Kerala focused food database
* Predefined recipes
* Daily + weekly + monthly progress tracking
* Water tracking
* Exercise tracking (basic)
* Analytics & reports
* Offline-first architecture
* CI/CD to auto-generate APK in `/apk-builds` folder

If free API is available → integrate it.
If API fails or has limitations → fallback to local JSON-based dummy database editable inside app.

---

# 🏗 TECH STACK

* Flutter (latest stable)
* Riverpod (state management)
* Clean Architecture (Data / Domain / Presentation)
* Hive or Isar (local storage)
* Free Nutrition API (if accessible):

  * Edamam (free tier) OR
  * Nutritionix (free tier) OR
  * OpenFoodFacts API
* Fallback: Local JSON food DB
* GitHub Actions for CI
* APK output inside `/apk-builds`

---

# 📂 PROJECT STRUCTURE

```
lib/
 ├── core/
 │    ├── constants/
 │    ├── theme/
 │    ├── utils/
 │    ├── extensions/
 │
 ├── data/
 │    ├── models/
 │    ├── datasources/
 │    ├── repositories/
 │
 ├── domain/
 │    ├── entities/
 │    ├── repositories/
 │    ├── usecases/
 │
 ├── presentation/
 │    ├── screens/
 │    ├── widgets/
 │    ├── providers/
 │
 ├── main.dart
```

---

# 🍛 FOOD DATABASE REQUIREMENTS

## If API works:

* Fetch calorie per 100g
* Macronutrients (carbs, protein, fat)
* Fiber if available
* Portion sizes

## If fallback:

Create local editable JSON inside:

```
assets/data/foods.json
assets/data/recipes.json
```

---

# 🥥 PREDEFINED KERALA / SOUTH INDIAN FOODS

Include minimum:

### Breakfast

* Appam
* Puttu
* Idiyappam
* Dosa
* Idli
* Upma
* Parotta
* Pazham + Puttu
* Kadala curry
* Sambar
* Coconut chutney

### Lunch

* Kerala rice
* Fish curry (meen curry)
* Chicken curry
* Avial
* Thoran (beans/cabbage)
* Sambar
* Rasam
* Curd
* Moru curry
* Beef fry (Kerala style)

### Dinner

* Chapathi
* Vegetable curry
* Egg roast
* Tomato curry
* Fish fry

### Snacks

* Banana chips
* Pazham pori
* Unniyappam
* Parippu vada
* Sukhiyan

Each must contain:

* Calories per 100g
* Macros
* Default serving size
* Editable calorie override option

---

# 🥗 PREDEFINED RECIPES

Include composite recipes:

* Kerala Fish Curry
* Chicken Roast
* Avial
* Beef Fry
* Vegetable Stew
* Egg Roast
* Sambar

Each recipe must:

* Contain ingredient list
* Auto calculate calories
* Allow portion scaling
* Allow save as custom recipe

---

# 📱 FEATURES

## 1️⃣ Authentication (Optional MVP)

* Local user profile
* Weight, height, age
* Goal (lose / maintain / gain)

## 2️⃣ Calorie Goal Calculation

Use Mifflin-St Jeor equation.
Auto calculate daily calories.
Allow manual override.

---

## 3️⃣ Home Screen

* Date selector
* Circular calorie progress
* Calories:

  * Consumed
  * Burned
  * Remaining
* Water tracker
* Meal cards:

  * Breakfast
  * Lunch
  * Dinner
  * Snacks
* Exercise toggle
* Expand meal → show items

---

## 4️⃣ Add Food Screen

* Search field
* Filter by:

  * Foods
  * Recipes
  * Favorites
* Quantity selector
* Gram-based input
* Add to meal
* Real-time calorie preview

---

## 5️⃣ Water Tracker

* Default 2.5L
* Add 0.2L increments
* Show progress indicator
* Persist daily

---

## 6️⃣ Exercise Tracking

Basic:

* Walking
* Running
* Cycling
* Gym

Manual calorie burn entry.
Optional: Step counter integration.

---

## 7️⃣ Reports Screen

Must include:

### Daily Report

* Total calories
* Macro breakdown pie chart
* Water intake
* Exercise burn

### Weekly Report

* Bar chart calories
* Weight trend

### Monthly Report

* Average calories
* Compliance score
* Goal success %

---

# 📊 ANALYTICS REQUIREMENTS

Generate:

* Calorie trend graph
* Macro distribution
* Weight progression graph
* Meal distribution %

Use fl_chart.

---

# 🧠 STATE MANAGEMENT

Riverpod providers:

* calorieProvider
* mealProvider
* waterProvider
* exerciseProvider
* reportProvider
* foodSearchProvider

Use async providers where needed.

---

# 💾 STORAGE

Use Hive/Isar for:

* Daily logs
* User profile
* Custom recipes
* Water intake
* Weight history

App must work offline.

---

# 🎨 UI REQUIREMENTS

* Follow Figma exactly
* Use green primary gradient
* Smooth animations
* Expand/collapse meal cards
* Clean card shadows
* Bottom navigation (Diary, Explore, Coach, Reports)

---

# 🚀 CI/CD REQUIREMENTS

Create GitHub Actions workflow:

`.github/workflows/flutter.yml`

Workflow must:

* Trigger on push to main
* Install Flutter
* Run flutter pub get
* Run flutter build apk --release
* Create folder:

```
apk-builds/
```

* Copy generated APK into:

```
apk-builds/app-release.apk
```

* Commit APK back to repo OR upload as artifact

---

# 📦 FINAL BUILD REQUIREMENT

At project completion:

Repo must contain:

```
apk-builds/app-release.apk
```

APK must:

* Install without crash
* Run offline
* Have predefined Kerala food DB

---

# 🧪 TESTING

Must include:

* Unit tests for calorie calculation
* Widget tests for meal expansion
* Provider tests
* Build test in CI

---

# 🔐 FUTURE SCALABILITY

Prepare architecture for:

* Firebase sync
* Subscription model
* Premium meal plans
* AI diet suggestions

---

# 🧾 MVP DELIVERABLE CHECKLIST

* [ ] UI matches Figma
* [ ] Kerala food DB included
* [ ] Calorie tracking works
* [ ] Water tracker works
* [ ] Reports working
* [ ] Offline persistence
* [ ] CI builds APK
* [ ] APK inside `/apk-builds`

---

# 🧠 MACHINE INSTRUCTION SUMMARY

You are to:

1. Build full Flutter app
2. Implement clean architecture
3. Use Riverpod
4. Add Kerala food DB
5. Add recipes
6. Implement analytics
7. Add local persistence
8. Create GitHub Actions CI
9. Auto-build release APK
10. Store final APK inside `/apk-builds`

No placeholders. No incomplete TODOs.
Production-ready structure required.

---

If you want, I can now also generate:

* ✅ The full GitHub Actions YAML
* ✅ Sample Kerala food JSON database
* ✅ Calorie calculation utility code
* ✅ Riverpod provider skeleton
* ✅ Folder-level task breakdown for Cursor execution
