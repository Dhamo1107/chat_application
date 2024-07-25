document.addEventListener('turbolinks:load', () => {
    document.querySelectorAll('.user-item-link').forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            const url = event.currentTarget.getAttribute('href');

            fetch(url, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Accept': 'text/javascript'
                }
            })
                .then(response => response.text())
                .then(data => {
                    document.getElementById('chat-content').innerHTML = data;
                });
        });
    });
});

