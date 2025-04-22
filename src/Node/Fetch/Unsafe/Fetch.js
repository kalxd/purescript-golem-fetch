/** headers */
export const _headers_empty = new Headers();
export const _headers_make = a => new Headers(a);

export const _headers_show = h => {
	let p = "";
	for (const [key, value] of h.entries()) {
		p += `${key}: ${value}, `;
	}

	return `Headers { ${p}}`;
};

export const _headers_append = key => value => h => {
	const clone = _headers_make(h);
	clone.append(key, value);
	return clone;
};

export const _headers_delete = key => h => {
	const clone = _headers_make(h);
	clone.delete(key);
	return clone;
};

export const _headers_entries = tuple => h => {
	let xs = [];
	for (const [key, value] of h.entries()) {
		xs.push(tuple(key)(value));
	}
	return xs;
};

export const _headers_get = just => nothing => key => h => {
	const v = h.get(key);
	if (v === null) {
		return nothing;
	}
	else {
		return just(v);
	}
};

export const _headers_has = key => h => h.has(key);

export const _headers_keys = h => {
	let xs = [];
	for (const key of h.keys()) {
		xs.push(key);
	}
	return xs;
};

export const _headers_set = key => value => h => {
	const clone = _headers_make(h);
	clone.set(key, value);
	return clone;
};

export const _headers_values = h => {
	let xs = [];
	for (const value of h.values()) {
		xs.push(value);
	}
	return xs;
};
/** end headers */

/** fetch */
export const _fetch_api = url => fetch(url);

export const _fetch_api2 = url => opt => fetch(url, opt);
/** end fetch */

/** misc */
export const _unwrap_maybe = isJust => fromJust => input => {
	let o = {};
	for (const key in input) {
		const v = input[key];
		if (isJust(v)) {
			o[key] = fromJust(v);
		}
	}
	return o;
};

export const _unsafe_total = a => a;
/** end misc */
