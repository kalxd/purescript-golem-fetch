import url from "node:url";

/** URLSearchParams */
export const _search_empty = new url.URLSearchParams();

export const _search_make = o => new url.URLSearchParams(o);

export const _search_show = s => s;

export const _search_toString = s => s.toString();

export const _search_append = key => value => search => {
	const clone = _search_make(search);
	clone.append(key, value);
	return clone;
};

export const _search_delete = key => search => {
	const clone = _search_make(search);
	clone.delete(key);
	return clone;
};

export const _search_entries = tuple => search => {
	let xs = [];
	for (const [a, b] of search.entries()) {
		xs.push(tuple(a)(b));
	}
	return xs;
};

export const _search_get = just => nothing => key => search => {
	const v = search.get(key);
	if (v === null) {
		return nothing;
	}
	else {
		return just(v);
	}
};

export const _search_getAll = key => search => search.getAll(key);

export const _search_has = key => search => search.has(key);

export const _search_keys = search => {
	let xs = [];
	for (const k of search.keys()) {
		xs.push(k);
	}
	return xs;
};

export const _search_set = key => value => search => {
	let clone = _search_make(search);
	clone.set(key, value);
	return clone;
};

export const _search_size = search => search.size;

export const _search_values = search => search.values();
/** end URLSearchParams */

export const _url = input => new url.URL(input);

export const _show = input => input.toString();
