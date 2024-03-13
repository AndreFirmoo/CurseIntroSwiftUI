# Stanford University's course CS193p (Developing Applications for iOS using SwiftUI) 1 of 12

## Intro SwiftUI

struct LoginView: View {
    var body: some View {
        GeometryReader {size in
            ZStack {
                Image(.casal)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(width: size.size.width, height: size.size.height)
                
                VStack {
                    Text("Um Banco de vantagens, \nmais simples e seguro\n pra ti")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .lineLimit(3)
                        .frame(width: size.size.width * 0.90, height: 200, alignment: .leading)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("acessar")
                            .background {
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(width: size.size.width * 0.90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .clipShape(.capsule)
                            }
                        
                    }).padding(.bottom, 30)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("não sou cliente")
                            .font(.headline)
                            .frame(width: size.size.width * 0.90, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.white)
                            
                        
                    })
                    HStack {
                        HStack(spacing: -10){
                         Image(systemName: "person")
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundStyle(.white)
                            Text("Pix")
                                .bold()
                                .foregroundStyle(.white)
                        }
                        HStack{
                            Image(systemName: "car")
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundStyle(.white)
                            Text("pix token")
                                .bold()
                                .foregroundStyle(.white)
                        }
                        HStack{
                            Image(systemName: "questionmark.square.dashed")
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundStyle(.white)
                            Text("Ajuda")
                                .bold()
                                .foregroundStyle(.white)
                        }
                    }
                    
                }.frame(width: size.size.width, height: size.size.height, alignment: .bottom)
            }
            
        }
    }
}

#Preview {
    LoginView()
}

