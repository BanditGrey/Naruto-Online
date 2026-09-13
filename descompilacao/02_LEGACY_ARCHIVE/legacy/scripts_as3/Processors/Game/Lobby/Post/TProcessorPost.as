package Processors.Game.Lobby.Post
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TPost;
   import Logics.HyperStrings.THyperString;
   import Logics.SLogicsCore;
   import Logics.Streamization.Post.TUnstreamizerPost;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import flash.utils.ByteArray;
   
   public class TProcessorPost extends TProcessorLobbyWindows
   {
      
      protected var FUnstreamizerPost:TUnstreamizerPost;
      
      protected var FHyperString:THyperString;
      
      protected var FOnPost:Function;
      
      protected var FOnMarquee:Function;
      
      public function TProcessorPost(param1:TUIComponent, param2:TLobbyParameters = null)
      {
         super(param1,param2);
         this.FUnstreamizerPost = new TUnstreamizerPost();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Post_NotifyInfo,this.PerformPacket_SC_NotifyInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Post_OnlyPostMarquee,this.PerformPacket_SC_OnlyPostMarquee);
         super.PacketRegisterRoutines();
      }
      
      protected function PerformPacket_SC_NotifyInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TPost = null;
         var _loc7_:String = null;
         _loc2_ = param1.Data;
         this.FHyperString = SLogicsCore.PoolHyperString.AcquireHyperString();
         this.FHyperString.Clear();
         _loc3_ = _loc2_.readUnsignedInt();
         SLogicsCore.PostIdentifier = _loc3_;
         if(_loc3_ != 81001023)
         {
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Post,_loc3_) as TPost;
         }
         this.FUnstreamizerPost.Unstreamize(_loc2_,this.FHyperString,_loc6_);
         if(this.FOnPost != null)
         {
            this.FOnPost(this,this.FHyperString,_loc6_);
         }
      }
      
      protected function PerformPacket_SC_OnlyPostMarquee(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TPost = null;
         var _loc5_:String = null;
         _loc2_ = param1.Data;
         this.FHyperString = SLogicsCore.PoolHyperString.AcquireHyperString();
         this.FHyperString.Clear();
         _loc5_ = TUtilityString.FetchUTF(_loc2_);
         this.FUnstreamizerPost.UnstreamizeOnlyOnMarQueen(_loc2_,this.FHyperString,_loc5_);
         if(this.FOnMarquee != null)
         {
            this.FOnMarquee(this,this.FHyperString);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      public function get OnPost() : Function
      {
         return this.FOnPost;
      }
      
      public function set OnPost(param1:Function) : void
      {
         this.FOnPost = param1;
      }
      
      public function set OnMarquee(param1:Function) : void
      {
         this.FOnMarquee = param1;
      }
      
      public function Test() : void
      {
         var _loc1_:TPost = null;
         var _loc2_:ByteArray = null;
         _loc2_ = new ByteArray();
         TUtilityString.FlushUTF(_loc2_,"{\'OutLineUnderline\':[\'点我\',\'http://www.163.com\']}");
         _loc2_.position = 0;
         this.FHyperString = SLogicsCore.PoolHyperString.AcquireHyperString();
         this.FHyperString.Clear();
         _loc1_ = new TPost();
         _loc1_.TestInit();
         this.FUnstreamizerPost.Unstreamize(_loc2_,this.FHyperString,_loc1_);
         if(this.FOnPost != null)
         {
            this.FOnPost(this,this.FHyperString,_loc1_);
         }
      }
   }
}

