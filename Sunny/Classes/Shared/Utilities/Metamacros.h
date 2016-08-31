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

#define DidUpdateCopyPropertyImplementation(name, didSetBlock)\
    if ([_##name isEqual:name]) {\
        return;\
    }\
    _##name = [name copy];\
    didSetBlock();

#define DidUpdateAssignPropertyImplementation(name, didSetBlock)\
if (_##name == name) {\
return;\
}\
_##name = name;\
didSetBlock();

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

#pragma mark - Initializers

#define MMASSERT_SHOULD_NOT_BE_REACHED NSAssert(NO, @"Shouldn't be reached");
#define MMASSERT_SHOULD_BE_OVERRIDDEN NSAssert(@NO, @"Should be overridden in a subclass");
#define MMCASSERT_SHOULD_NOT_BE_REACHED NSCAssert(NO, @"Shouldn't be reached");

#ifndef MM_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE
#define MM_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE \
__attribute__((unavailable("Not the designated initializer")))
#endif

#define MM_EMPTY_INIT_UNAVAILABLE \
- (nullable instancetype)init MM_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE; \
+ (nullable instancetype)new MM_NOT_DESIGNATED_INITIALIZER_ATTRIBUTE;

#define MM_NOT_DESIGNATED_NONNULL_INITIALIZER() MM_NOT_DESIGNATED_INITIALIZER_CUSTOM(init)
#define MM_NOT_DESIGNATED_INITIALIZER() MM_NOT_DESIGNATED_INITIALIZER_CUSTOM(init)
#define MM_NOT_DESIGNATED_INITIALIZER_CUSTOM(initName) MM_NOT_DESIGNATED_INITIALIZER_CUSTOM_NULLABILITY(initName, nullable)
#define MM_NOT_DESIGNATED_NONNULL_INITIALIZER_CUSTOM(initName) MM_NOT_DESIGNATED_INITIALIZER_CUSTOM_NULLABILITY(initName, nonnull)
#define MM_NOT_DESIGNATED_INITIALIZER_CUSTOM_NULLABILITY(initName, nullabilityType) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wobjc-designated-initializers\"") \
- (nullabilityType instancetype)initName \
{ do { \
NSAssert2(NO, @"%@ is not the designated initializer for instances of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class])); \
return nil; \
} while (0); } \
_Pragma("clang diagnostic pop")
