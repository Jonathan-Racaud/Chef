namespace System.Collections
{
	extension List<T> where T: delete
	{
		public void DeleteAt(int index)
		{
			let elem = this[index];

			delete elem;

			this.Remove(elem);
		}

		public void DeleteRange(int index, int count)
		{
			let elements = this.GetRange(index, count);

			for (let element in elements)
			{
				delete element;
			}

			this.RemoveRange(index, count);
		}
	}
}
