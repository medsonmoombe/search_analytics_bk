import { Controller } from "@hotwired/stimulus"
import { debounce } from "debounce"

export default class extends Controller {
    static targets = ["input", "results", "loading"]
    

    connect() {
        this.debouncedSearch = debounce(this.search.bind(this), 300)
        console.log("SearchAnalyticsController connected")
    }
    
    trackSearch(){
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
           this.#performSearch(this.inputTarget.value)
        }, 500)
    }

    #performSearch(query) {
        if(query.length > 0) {
            this.loadingTarget.classList.remove("hidden")
            this.resultsTarget.classList.add("hidden")
            fetch('/search/track', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({ query })
              }).then(response => {
                console.log("Search tracked", response)
              })
        }
    }

}