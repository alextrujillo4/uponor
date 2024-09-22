## Uponorflix - Movie Streaming Prototype

<video src='https://youtu.be/wB2nylZbbUs' width=600></video>

**Description**

This project is a **Flutter** mobile application prototype designed to demonstrate a movie streaming
service called **Uponorflix**. The goal is to convince the marketing department of Uponor that this
is a viable project to enter the VOD market. The app provides users with access to popular movies,
allowing them to add, edit, and delete movies from the catalog. It features basic CRUD operations
and supports both list and grid views for better navigation.

### Personal Info

I'm **Alex Trujillo**, a passionate software developer with expertise in mobile app development
using Flutter. You can find my work on:

* **Website:** [https://alextrujillo4.com/](https://alextrujillo4.com/)

I'm thrilled to present this project for evaluation by the **Uponor** team. Thank you for
considering my work.

### The Project:

**Core Features:**

* **Catalog:** Displays all movies in the catalog with detailed information such as title, overview,
  release date, genres, and poster images.
* **Add and Edit Movie:** A form that allows users to create new movie entries or edit existing
  ones.
* **Delete Movie:** Provides the functionality to remove movies from the catalog.
* **Responsive Views:** Toggle between list and grid view modes to offer different browsing
  experiences.
* **Error Handling:** Includes mechanisms to handle various errors, including API errors and
  connection issues.

### The Scope

The goal of this prototype is to simulate a streaming platform and showcase a user-friendly
interface that allows catalog manipulation, providing a solid foundation for future development.

**Key Points:**

* We recommend integrating tests to avoid unexpected failures.
* Feel free to use any library you deem necessary to enhance the functionality.

### Running the Code

**Prerequisites:**

- Install **Flutter Version Manager (FVM)
  **: [FVM Installation Guide](https://github.com/fvm-sh/fvm?tab=readme-ov-file#listing-versions)
- Working project versions:
    - Dart: `3.2.0`
    - Flutter: `3.16.0`

**Steps:**

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   ```

2. **Navigate to the project directory:**
   ```bash
   cd <project_directory>
   ```

3. **Set up API key:**
   Create a `.env` file in the root directory and add your API key for movie data:
   ```
   BEARER=your_api_key_here
   ```

4. **Install dependencies:**
   ```bash
   make get
   ```

5. **Build the project:**
   ```bash
   make build
   ```

6. **Run the app:**
   Ensure you have an Android or iOS emulator running, then execute:
   ```bash
   fvm flutter run
   ```

### Additional Makefile Commands

* **Run tests:**
   ```bash
   make tests
   ```

* **Lint the project:**
   ```bash
   make lint
   ```

* **Clean the project:**
   ```bash
   make clean
   ```

* **Generate APK:**
   ```bash
   make create-apk
   ```

### Project Structure Overview

The project follows a modular and scalable architecture to promote separation of concerns and
maintainability. Here's an overview of the main structure:

#### Feature Packages

Located in `lib/features/`, the following packages define the main app functionalities:

1. **`catalog`**: Manages the movie catalog display and operations.
2. **`movie_form`**: Handles adding and editing movies through a user form.
3. **`movie_detail`**: Displays detailed information about individual movies.
4. **`delete_movie`**: Implements logic for deleting movies.

#### Core Packages

These core utilities and services are stored in `lib/core/`:

2. **`state_management`**: Provides state management using **Bloc**.
3. **`failure`**: Contains error types for handling application failures.
4. **`cache`**: Provides local caching functionality for movie data.

#### Data & Domain Packages

The domain and data-related packages live under `lib/domain/` and `lib/data/`:

- **Entities**: Core business objects like `movie.dart`, `genre.dart`, etc.
- **Repository**: Interfaces and implementations of repositories.
- **Use Cases**: Business logic encapsulated in use case classes like `add_movie_usecase.dart`.

#### Testing

- Unit tests are located under `test/` directories in each package.
- Widget tests are located at the project root in the `test/` folder.
- Integration tests reside in the `integration_test/` folder.
