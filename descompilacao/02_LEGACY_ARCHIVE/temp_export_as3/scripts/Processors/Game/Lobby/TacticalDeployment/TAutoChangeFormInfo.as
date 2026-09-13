package Processors.Game.Lobby.TacticalDeployment
{
   public class TAutoChangeFormInfo
   {
      
      public var FormId:int;
      
      public var HeroInfo:Vector.<TAutoChangeFormHeroInfo>;
      
      public function TAutoChangeFormInfo()
      {
         super();
         this.HeroInfo = new Vector.<TAutoChangeFormHeroInfo>();
      }
      
      public function Add(param1:TAutoChangeFormHeroInfo) : void
      {
         this.HeroInfo.push(param1);
      }
   }
}

