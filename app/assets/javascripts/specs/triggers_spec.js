describe('Triggers', function(){
  beforeEach(function(){
    GlucoseAmigo.controller.redirectTo = function(data){
      //Do nothing
    }

    // Mock Ajax
    Ajax = (function(){
      return {
        logout: function(arg, callback){
          // Ajax call and then fire the callback on success
          callback();
        }
      }
    }())
  });
  it('should use redirectTo if you call login in the controller',function(){
    spyOn(GlucoseAmigo.controller, 'redirectTo');
    GlucoseAmigo.controller.login('test');
    expect(GlucoseAmigo.controller.redirectTo).toHaveBeenCalledWith('test');
  });
  it("should call Ajax's logout and the callback when you logout", function(){
    spyOn(GlucoseAmigo.controller, 'redirectTo');
    GlucoseAmigo.controller.logout();
    expect(GlucoseAmigo.controller.redirectTo).toHaveBeenCalled();
  })
});
