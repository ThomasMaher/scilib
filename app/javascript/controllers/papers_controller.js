import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ 'paper', 'route', 'message' ]

    submit() {
        const targetPaperIds = this.paperTargets.filter((paper) => paper.checked).map(paper => paper.value)
        const url = `http://localhost:3000${this.routeTarget.value}`
        console.log(url)
        console.log(targetPaperIds)
        fetch(url, {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
                // 'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: JSON.stringify({"papers": targetPaperIds})
        })
        .then(response => response.text())
        .then(html => this.messageTarget.innerHTML = html)
    }
}