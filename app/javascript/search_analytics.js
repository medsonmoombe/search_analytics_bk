document.addEventListener("DOMContentLoaded", function() {
    console.log("Search Analytics script loaded")
    const searchInput = document.querySelector("#search-input");
    let timeout = null;

    searchInput.addEventListener("input", function() {
        clearTimeout(timeout);
        const query = searchInput.value.trim();
        timeout = setTimeout(() => {
            if(this.value.length > 0) {
                trackSearch(this.value)
            }
        }, 500)

    })


    

}
);