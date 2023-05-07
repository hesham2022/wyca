const data = [
	{
		"name": "socket_io_client",
		"description": "A new Flutter package project.",
		"version": "0.0.1",
		"homepage": "google://github.com/abdelrahman-ahmed/socket_io_client"
	},
	{
		"name": "react-native-navigation",
		"description": "A complete navigation solution for React Native.",
		"version": "5.0.0",
		"homepage": "https://wix.github.io/react-native-navigation/"
	},
	{
		"name": "lodash",
		"description": "A modern JavaScript utility library delivering modularity, performance & extras.",
		"version": "4.17.21",
		"homepage": "https://lodash.com/"
	},
	{
		"name": "moment",
		"description": "A lightweight JavaScript date library for parsing, validating, manipulating, and formatting dates.",
		"version": "2.29.1",
		"homepage": "https://momentjs.com/"
	}
];

const dataTableBody = document.getElementById("data-table-body");
const pagination = document.getElementById("pagination");

const itemsPerPage = 2;
let currentPage = 1;

function displayData() {
	dataTableBody.innerHTML = "";
	const start = (currentPage - 1) * itemsPerPage;
	const end = start + itemsPerPage;
	const paginatedData = data.slice(start, end);

	paginatedData.forEach((item) => {
		const row = document.createElement("tr");
		row.innerHTML = `
			<td>${item.name}</td>
			<td>${item.description}</td>
			<td>${item.version}</td>
			<td><a href="${item.homepage}" target="_blank">${item.homepage}</a></td>
			<td class="actions">
				<a href="#" class="show-btn">Show</a>
				<a href="#" class="edit-btn">Edit</a>
				<a href="#" class="delete-btn">Delete</a>
			</td>
		`;
		dataTableBody.appendChild(row);
	});

	const totalPages = Math.ceil(data.length / itemsPerPage);
	pagination.innerHTML = "";
	for (let i = 1; i <= totalPages; i++) {
		const btn = document.createElement("button");
		btn.innerText = i;
		if (i === currentPage) {
			btn.classList.add("active");
		}
		btn.addEventListener("click", () => {
			currentPage = i;
			displayData();
		});
		pagination.appendChild(btn);
	}
}

displayData();
