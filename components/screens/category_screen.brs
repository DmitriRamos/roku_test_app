function init()
    m.category_list=m.top.findNode("category_list")
    m.category_list.setFocus(true)
        m.top.observeField("visible", "onVisibleChange")
end function

function updateConfig(params)
    categories = params.config.categories
    contentNode = createObject("roSGNode", "ContentNode")
    for each category in categories
        node = createObject("roSGNode", "category_node")
        node.title = category.title
        node.feed_url = params.config.host + category.feed_url
        contentNode.appendChild(node)
    end for
    m.category_list.content = contentNode
end function

sub onVisibleChange()
        if m.top.visible = true then
                m.category_list.setFocus(true)
        end if
end sub




