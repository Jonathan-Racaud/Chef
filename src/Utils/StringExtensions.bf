using System.Collections;

namespace System
{
	extension String
	{
		public List<String> Split(String separator, int occurrence = -1)
		{
			var strings = new List<String>();
			var temp = scope String(this);

			var index = temp.IndexOf(separator);
			var timesSeparated = 0;

			while (index != -1)
			{
				timesSeparated++;

				let subStr = new String();
				subStr.Set(temp.Substring(0, index));
				strings.Add(subStr);

				temp.Set(temp.Substring(index + separator.Length));

				if (timesSeparated == occurrence)
					break;

				index = temp.IndexOf(separator);
			}

			if (temp.Length > 0)
			{
				let subStr = new String();
				subStr.Set(temp);
				strings.Add(subStr);
			}

			return strings;
		}
	}
}
