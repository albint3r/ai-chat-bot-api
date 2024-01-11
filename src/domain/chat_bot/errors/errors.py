class ErrorFormatIndexName(Exception):
    """Raise this error when the index name in Pinecone don't follow the next format:
    Can only contain lowercase letters, numbers, and hyphens."""
