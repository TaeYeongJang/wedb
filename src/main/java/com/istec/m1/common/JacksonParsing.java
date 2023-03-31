package com.istec.m1.common;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.istec.m1.utils.CommonMap;

public class JacksonParsing {
	private static String CHARSET = "utf-8";

	public static CommonMap toMap(String json) {
		CommonMap result = null;
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.readValue(json, new TypeReference<CommonMap>() {});
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}
	public static List<CommonMap> toList(String json) {
		List<CommonMap> result = null;
		try {
			ObjectMapper mapper = new ObjectMapper();
			result = mapper.readValue(json, new TypeReference<List<CommonMap>>() {});
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}

	public static String toString(Object object) {
		return toString(object, CHARSET);
	}
	public static String toString(Object object, String charset) {
		ByteArrayOutputStream output = null;
		Writer write = null;
		String data = null;

		try{
			output = new ByteArrayOutputStream();
			write = new OutputStreamWriter(output, charset);

			ObjectMapper mapper = new ObjectMapper();
			mapper.writeValue(write, object);
			data = output.toString(charset);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			if(output != null) try { output.close(); } catch (IOException e) { }
			if(write != null) try { write.close(); } catch (IOException e) { }
		}

		return data;
	}
}