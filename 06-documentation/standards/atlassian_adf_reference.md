# Atlassian Document Format (ADF) Reference

**Source**: https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/

## Purpose

The Atlassian Document Format (ADF) represents rich text stored in Atlassian products. For example, in Jira Cloud platform, the text in issue comments and in `textarea` custom fields is stored as ADF.

## JSON Schema

An Atlassian Document Format document is a JSON object. A JSON schema is available to validate documents. This JSON schema is found at http://go.atlassian.com/adf-json-schema.

## JSON Structure

An ADF document is composed of a hierarchy of _nodes_. There are two categories of nodes: block and inline. Block nodes define the structural elements of the document such as headings, paragraphs, lists, and alike. Inline nodes contain the document content such as text and images.

### Example ADF Document

```json
{
  "version": 1,
  "type": "doc",
  "content": [
    {
      "type": "paragraph",
      "content": [
        {
          "type": "text",
          "text": "Hello "
        },
        {
          "type": "text",
          "text": "world",
          "marks": [
            {
              "type": "strong"
            }
          ]
        }
      ]
    }
  ]
}
```

Results in: "Hello **world**"

## Node Properties

| Property | Required | Description |
|----------|----------|-------------|
| type | ✔ | Defines the type of block node such as paragraph, table, and alike |
| content | ✔ in block nodes | An array containing inline and block nodes that define the content |
| version | ✔ in root only | Defines the version of ADF used in this representation |
| marks | Optional | Defines text decoration or formatting |
| attrs | Optional | Further information defining attributes of the block |

## Code Block Structure

For JSON code blocks, use this structure:

```json
{
  "type": "codeBlock",
  "attrs": {
    "language": "json"
  },
  "content": [
    {
      "type": "text",
      "text": "{ \"your\": \"json content here\" }"
    }
  ]
}
```

## Block Nodes

### Top-level Block Nodes
- blockquote
- bulletList  
- **codeBlock** ← For JSON formatting
- expand
- heading
- mediaGroup
- mediaSingle
- orderedList
- panel
- paragraph
- rule
- table

### Child Block Nodes
- listItem
- media
- nestedExpand
- tableCell
- tableHeader
- tableRow

## Inline Nodes
- date
- emoji
- hardBreak
- inlineCard
- mention
- status
- **text** ← For content
- mediaInline

## Marks

Available marks for text formatting:
- **strong** (bold)
- em (italic)
- code (inline code)
- link
- strike
- underline
- textColor
- subsup (superscript/subscript)

## Usage Notes

1. **Comments require ADF format** - plain text causes 400 errors
2. **Code blocks need proper structure** with type, attrs, and content
3. **Text content goes in text nodes** with type: "text"
4. **JSON content must be escaped** properly for ADF
5. **Version should be 1** in root doc node
