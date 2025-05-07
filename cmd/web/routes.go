package main

import (
	"net/http"
	"time"

	"github.com/go-chi/cors"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
)

func (app *application) routes() http.Handler {
	mux := chi.NewRouter()

	mux.Use(middleware.Logger)
	mux.Use(middleware.RealIP)
	mux.Use(middleware.Timeout(60 * time.Second))
	mux.Use(cors.Handler(cors.Options{
		AllowedOrigins:   []string{"*"}, // atur domain frontend-mu jika perlu
		AllowedMethods:   []string{"GET", "POST", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type"},
		AllowCredentials: false,
		Debug:            false,
	}))

	mux.Get("/", home)
	mux.Get("/jobs", app.getJobs)
	mux.Get("/job/{id}", app.getJob)
	mux.Post("/job", app.InsertJob)
	mux.Delete("/job/{id}", app.DeleteJob)
	mux.Get("/health", app.health)

	return mux
}
