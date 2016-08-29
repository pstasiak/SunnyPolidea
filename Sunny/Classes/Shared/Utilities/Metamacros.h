#pragma mark - Casting

#define DynamicCast(object) (id) object
#define PropertyName(property) NSStringFromSelector(@selector(property))

#pragma mark - Properties

#define LazyProperty(class, name, creationBlock) \
- (class)name {       \
    if(!_##name) {      \
        _##name = creationBlock(); \
    }                   \
    return _##name;     \
}

#pragma mark - Cast View

/*
    First argument - Class name
    Second argument (optional) - method name (default: castView)
 */
#define CastView(class, ...)            \
    _CallX(,                            \
        ##__VA_ARGS__,                  \
        _CastView(class, __VA_ARGS__),  \
        _CastView(class, castView)      \
    )

#define _CastView(class, name) \
- (class *)name { \
    return self.isViewLoaded ? (class *) self.view : nil; \
}

#pragma mark - Helpers

#define _CallX(_1, _2, FUNC, ...) FUNC
