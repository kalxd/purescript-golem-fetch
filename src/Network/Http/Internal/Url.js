import url from "node:url";

/** URLSearchParams */
export const _search_empty = new url.URLSearchParams();

export const _search_make = o => new url.URLSearchParams(o);

export const _search_show = s => s;

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

export const _search_get = just => nothing => key => search => {
	const v = search.get(key);
	if (v === null) {
		return nothing;
	}
	else {
		return just(v);
	}
};
/** end URLSearchParams */

export const _url = input => new url.URL(input);

export const _show = input => input.toString();
